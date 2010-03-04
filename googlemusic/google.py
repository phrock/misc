# -*- coding: utf-8 -*-
import rhythmdb
import rb

import re
import hashlib
import math
import traceback
from OnlineMusicConfigure import Preference
def decode(html):
  codeReg=re.compile('&#[\d]+;')
  ite=codeReg.finditer(html)
  res=""
  n=0
  for e in ite:
    res+=html[n:e.start()]
    n=e.end()
    words=e.group()
    res+=unichr(int(words[2:len(words)-1]))
  res+=html[n:]
  return res
def getSongUrl(xmlurl):
  req = Request(xmlurl)
  try:
    response = urlopen(req)
  except URLError, e:
    print 'error'
  else:
    try:
      xmlback=response.read()
      #print xmlback
      dom1=parseString(xmlback)
      url=dom1.getElementsByTagName('songUrl')[0].childNodes[0].nodeValue
      #lyric=dom1.getElementsByTagName('lyricsUrl')[0].childNodes[0].nodeValue
      return url
    except Exception, e:
      print 'error'
  return None
  
def getSongList(xmlurl):
  GOOGLE_PLAYER_KEY = "ecb5abdc586962a6521ffb54d9d731a0";
  req = Request(xmlurl)
  try:
    response = urlopen(req)
  except URLError, e:
    print 'error'
  else:
    xmlback=response.read()
    #print xmlback
    dom1=parseString(xmlback)
    genre=dom1.getElementsByTagName('info')[0].childNodes[1].childNodes[0].nodeValue
    elements=dom1.getElementsByTagName('song')
    #print len(elements)
    songs = []
    count = 1
    for element in elements:
      id=element.getElementsByTagName('id')[0].childNodes[0].nodeValue
      name=element.getElementsByTagName('name')[0].childNodes[0].nodeValue
      artist=element.getElementsByTagName('artist')[0].childNodes[0].nodeValue
      album=element.getElementsByTagName('album')[0].childNodes[0].nodeValue
      durationf=float(element.getElementsByTagName('duration')[0].childNodes[0].nodeValue)
      duration=int(math.ceil(durationf))
      track_number = count
      count += 1
      #print 'soundId:',id,"@",'soundName:',name,'artist:',artist
      hash = hashlib.md5(GOOGLE_PLAYER_KEY + id).hexdigest()      url="http://www.google.cn/music/songstreaming?id=" + id + "&output=xml&sig=" + hash
      song={'name':name,
        'artist':artist,
        'album':album,
        'duration':duration,
        'url':url,
        'genre':genre,
        'track_number':track_number}
      songs.append(song)
    return songs
  return None
class OnlineMusic():
  def activate(self):pass
  def __init__(self,source):
    self.source = source
    self.db=source.db
    self.entry_type=source.entry_type
    self.songPage=range(0,8)
    self.page=0
    self.preference = Preference()
    self.listType, self.listId, self.album = self.preference.get_prefs()
    
  def deactivate(self):
    self.db = None
    self.entry_type = None
    self.source = None
    self.preference = None
  
  def add_song(self,song):
    entry = self.db.entry_new(self.entry_type, song['url'])
    self.db.set(entry, rhythmdb.PROP_TITLE, song['name'])
    self.db.set(entry, rhythmdb.PROP_ARTIST, song['artist'])
    self.db.set(entry, rhythmdb.PROP_ALBUM, song['genre'])
    self.db.set(entry, rhythmdb.PROP_DURATION, song['duration'])
    self.db.set(entry, rhythmdb.PROP_TRACK_NUMBER, song['track_number'])
    self.db.set(entry, rhythmdb.PROP_GENRE, song['album'])
  def nextPage(self):
    if self.page<7:self.page+=1
    self.activate()
  def prePage(self):
    if self.page>=1:self.page-=1
    self.activate()
  def reloadMusic(self):
    self.listType, self.listId, self.album = self.preference.get_prefs()
    self.activate()
  '''  
  def activate(self):
    songs=self.getList()
    for song in songs:
      self.add_song(song)
    self.db.commit()
  '''
from urllib2 import Request, urlopen, URLError
import urllib2
from xml.dom.minidom import parse, parseString
class GoogleMusic(OnlineMusic):
  GOOGLE_PLAYER_KEY = "ecb5abdc586962a6521ffb54d9d731a0";#ecb5abdc586962a6521ffb54d9d731a0Sdddbf809708207e6
  def __init__(self,source):
    OnlineMusic.__init__(self,source)
  def parseSongList(self,html):
    #html=re.sub('<[/]*b>', '', html)#<td class=\"%s[ BottomBorder]*\">[\n]*<a[^>]*>[^<]*
    titleReg= re.compile("<td class=\"Title BottomBorder\"><a[^>]*>[^<]*")
    artistReg= re.compile("<td class=\"Artist BottomBorder\">\n<a[^>]*>[^<]*")
    titles=titleReg.findall(html)
    artists=artistReg.findall(html)
    songs=[]
    for title,artist in zip(titles,artists):
      id=title.split("%3D")[1].split("%")[0]
      name=decode(title.split(">")[2])
      artist=decode(artist.split(">")[2])
      #print 'soundId:',id,"@",'soundName:',name,'artist:',artist
      hash = hashlib.md5(self.GOOGLE_PLAYER_KEY + id).hexdigest()      url="http://www.google.cn/music/songstreaming?id=" + id + "&output=xml&sig=" + hash
      song={'name':name,'artist':artist,'url':url}
      songs.append(song)
      #self.getSongUrl(song)
    #print songs
    return songs
   
  def activate(self):
    self.source.notify_progress(True)
    #if self.songPage[self.page]!=self.page:
    #  self.addSongs(self.songPage[self.page])
    #  return
    #print 'Activate,get page:',page
    http = rb.Loader()
    url="http://www.google.cn/music/chartlisting?cat=song&q=chinese_songs_cn&output=xml"
    if self.listType is not None and self.listId is not None:
      #print 'listType=%s, listId=%s' % (self.listType, self.listId)
      if self.listType == 'song':
        url="http://www.google.cn/music/chartlisting?cat=song&q=%s&output=xml" % self.listId
      elif self.listType == 'topic':
        url="http://www.google.cn/music/topiclisting?cat=song&q=%s&output=xml" % self.listId
    #http.get_url(url, self.loadListBack)
    print url
    self.loadListBack(url)
  def loadListBack(self,html):
    #songs=self.parseSongList(html)
    songs=getSongList(html)
    self.addSongs(songs)
  def addSongs(self,songs):
    #if self.songPage[self.page]==self.page:
    #  self.songPage[self.page]=songs
    #TODO 删除列表时，存在播放过的歌曲的列表不删除
    for row in self.source.props.query_model:
      entry = row[0]
      self.db.entry_delete(entry)
    self.db.commit()
    
    for song in songs:
      self.add_song(song)
    self.db.commit()
    self.source.notify_progress(False)
