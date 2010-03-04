# -*- coding: utf-8 -*-

# __init__.py

import rb
import gobject
import gtk
import rhythmdb

import sys,os.path
from google import GoogleMusic
from OnlineMusicConfigure import OnlineMusicConfigureDialog
import google
import traceback

class Plugin(rb.Plugin):
  def __init__(self):
    self.switch = None
    rb.Plugin.__init__(self)

  def activate(self, shell):
    self.db = shell.props.db

    group = rb.rb_source_group_get_by_name ("online")
    if not group:
        group = rb.rb_source_group_register ("online",
                             _("Online"),
                             rb.SOURCE_GROUP_CATEGORY_FIXED)

    self.entry_type = self.db.entry_register_type("GoogleMusic")
    self.entry_type.get_playback_uri=self.get_playback_uri
    theme = gtk.icon_theme_get_default()
    theme.append_search_path(os.path.join(self.__get_plugins_dir(), "icons"))
    rb.append_plugin_source_path(theme, "/icons")

    width, height = gtk.icon_size_lookup(gtk.ICON_SIZE_LARGE_TOOLBAR)
    icon = rb.try_load_icon(theme, "googlemusic", width, 0)

    self.source = gobject.new (OnlineMusicSource,
                   shell=shell,
                   entry_type=self.entry_type,
                   source_group=group,
                   name = _("Google Music"),
                   icon=icon,
                   plugin=self)

    shell.register_entry_type_for_source(self.source, self.entry_type)
    shell.append_source(self.source, None)

    # First lets see if we can add to the context menu
    ui = shell.get_ui_manager()

    # Group and it's actions
    self.action_group = gtk.ActionGroup ('TestActions')

    # Create Actions for the plugin
    action = gtk.Action ('ReloadMusic', _('Reload music'),
                         _('Reload music'),
                         'gtk-refresh')
    activate_id = action.connect ('activate', lambda a: self.source.onlineMusic.reloadMusic())#self.source.onlineMusic.activate()
    self.action_group.add_action (action)
    action = gtk.Action ('SwitchList', _('Switch List'),
                         _('Switch List'),
                         'gtk-properties')#gtk-preferences
    activate_id = action.connect ('activate', lambda a: self.switch_list())
    self.action_group.add_action (action)

    ui.insert_action_group(self.action_group, -1)

  def deactivate(self, shell):
    ui = shell.get_player().get_property('ui-manager')
    ui.remove_action_group(self.action_group)
    self.action_group = None
    
    for row in self.source.props.query_model:
        entry = row[0]
        self.db.entry_delete(entry)
    self.db.commit()
    
    self.db = None
    self.entry_type = None
    
    self.source.delete_thyself()
    self.source = None
    self.switch = None
      
  def create_configure_dialog(self, dialog=None):
		if not dialog:
			dialog = OnlineMusicConfigureDialog().get_dialog()
		dialog.present()
		return dialog
	
  def switch_list(self):
    self.switch = OnlineMusicConfigureDialog().get_dialog()
    self.switch.present()
		
  def get_playback_uri(self,entry):
    if not entry:return None
    url=self.db.entry_get (entry, rhythmdb.PROP_LOCATION)
    if not url.endswith('.mp3'):
      url=google.getSongUrl(url)
      if url:
        try:
          self.db.set(entry, rhythmdb.PROP_LOCATION, url)
        except Exception, e:
          traceback.print_exc()
          return None
      else:
        return None
    return url

  def __get_plugins_dir (self):
    fr = sys._getframe(0)
    co = fr.f_code
    filename = co.co_filename
    dir = filename[:filename.rfind(os.sep)]
    return dir

class OnlineMusicSource(rb.BrowserSource):
  def __init__(self):
    rb.BrowserSource.__init__(self)
    self.__activated=False
    self.onlineMusic=None
    self.__progressing=False
    
  def do_impl_delete_thyself(self):
    if self.onlineMusic:
      self.onlineMusic.deactivate()
    
    self.onlineMusic = None
    self.entry_type = None
    self.db = None
    self.shell = None
    
    rb.BrowserSource.do_impl_delete_thyself (self)
    
  def do_impl_activate(self):
    if not self.__activated:
      self.__activated=True
      self.shell=self.get_property('shell')
      self.db = self.shell.get_property('db')
      self.entry_type = self.get_property('entry-type')
      self.onlineMusic=GoogleMusic(self)
      self.onlineMusic.activate()
      
      #player=self.shell.get_player().get_property('player')
      #player.connect("eos",self.eos,self.shell.get_player())
      #player.connect("buffering",self.eos,self.shell.get_player())

      #player.connect("playing-song-changed",self.entry_activated)#playing_song_changed)
      #player.connect("playing-changed",self.playing_changed)
      #self.get_entry_view().connect("entry-activated",self.entry_activated)
    rb.BrowserSource.do_impl_activate (self)
    
  def do_impl_get_ui_actions(self):
    return ["ReloadMusic", "SwitchList"]
    
  def do_impl_get_status(self):
    if self.__progressing:
      return (_("Loading songs"), None, -1.0)
    else:
      return (_("Done"), None, 1.0)
  
#  def eos(self,player,stream_data,progress,shellplayer):
#    out = open('/home/longming/test/x.mp3', 'w')
#    out.write(str(stream_data))
#    out.close()
    
  def notify_progress(self,progressing):
    self.__progressing=progressing
    self.notify_status_changed()
    
gobject.type_register(OnlineMusicSource)
