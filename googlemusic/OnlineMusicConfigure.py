# -*- coding: utf-8 -*-
#!/usr/bin/env python
import pygtk
import gtk
import gconf
import os
import traceback
import xdg.BaseDirectory
from xml.dom.minidom import parse, parseString
from CreateXML import CreateChartXML,CreateTopicXML

class OnlineMusicConfigureDialog (object):
  def __init__(self):
    self.preference = Preference()
    self.path = os.path.join(xdg.BaseDirectory.xdg_cache_home, "rhythmbox", "googlemusic")
    if not os.path.isdir(self.path):
        os.makedirs(self.path, 0700)
        chartxml = CreateChartXML()
        groups, charts = chartxml.pareseHTML()
        chartxml.createFile(groups, charts)

        topicxml = CreateTopicXML()
        groups, charts = topicxml.pareseHTML()
        topicxml.createFile(groups, charts)
    self.chartFileName = 'chartlist.xml'
    self.topicFileName = 'topiclist.xml'
    self.dialog = self.initDialog()
    self.dialog.connect("response", self.dialog_response)
    
  def dialog_response(self, dialog, response):
    selections = {
      0 : lambda : self.chartTree.get_selection(),
      1 : lambda : self.topicTree.get_selection()
    }
    page = self.notebook.get_current_page()
    if response == gtk.RESPONSE_OK:
      selection = selections.get(page, lambda : self.chartTree.get_selection())()
      (model, iter) = selection.get_selected()
      if iter:
        listName = model.get_value(iter, 0)
        listId = model.get_value(iter, 1)
        listType = model.get_value(iter, 2)
        if listType == 'song' or listType == 'topic':
          self.preference.set_values(listType, listId, listName)
          self.dialog.hide()
        else:
          msgBox = gtk.MessageDialog(parent=self.dialog, flags=gtk.DIALOG_MODAL, type=gtk.MESSAGE_ERROR, 
            buttons=gtk.BUTTONS_CLOSE, message_format=_("Select the row that type column is 'song'!"))
          msgBox.connect("response", lambda a, b: msgBox.hide())
          msgBox.run()
      
    elif response == gtk.RESPONSE_CANCEL or response == gtk.RESPONSE_DELETE_EVENT:
      self.dialog.hide()
    else:
      print "unexpected response type"
    
  def get_dialog (self):
    return self.dialog
    
  def initDialog(self):
    dialog = gtk.Dialog(_("Google Music Preference"),
                      None,
                      gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                      (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,
                      gtk.STOCK_OK, gtk.RESPONSE_OK))
                      
    dialog.set_size_request(500, 600)
    
    # create a TreeStore with one string column to use as the model
    self.notebook = gtk.Notebook()
    self.notebook.append_page(self.initChartTree(), gtk.Label(_('Chart List')))
    self.notebook.append_page(self.initTopicTree(), gtk.Label(_('Topic List')))

    vbox = dialog.get_content_area()
    vbox.pack_start(self.notebook, True)
    vbox.show_all()
    return dialog
  
  def initChartTree(self):
    treestore = gtk.TreeStore(str, str, str)
    # we'll add some data now - 4 rows with 3 child rows each
    self.loadChartData(treestore)
    # create the TreeView using treestore
    self.chartTree = gtk.TreeView(treestore)
    # create the TreeViewColumn to display the data
    tvcolumn = gtk.TreeViewColumn(_('Name'))
    tvcolumn2 = gtk.TreeViewColumn(_('Id'))
    tvcolumn3 = gtk.TreeViewColumn(_('Type'))
    # add tvcolumn to treeview
    self.chartTree.append_column(tvcolumn)
    self.chartTree.append_column(tvcolumn2)
    self.chartTree.append_column(tvcolumn3)
    # create a CellRendererText to render the data
    cell = gtk.CellRendererText()
    # add the cell to the tvcolumn and allow it to expand
    tvcolumn.pack_start(cell, True)
    tvcolumn2.pack_start(cell, True)
    tvcolumn3.pack_start(cell, True)
    # set the cell "text" attribute to column 0 - retrieve text
    # from that column in treestore
    tvcolumn.add_attribute(cell, 'text', 0)
    tvcolumn2.add_attribute(cell, 'text', 1)
    tvcolumn3.add_attribute(cell, 'text', 2)
    
    # make it searchable
    #self.treeview.set_search_column(0)
    # Allow sorting on the column
    #self.tvcolumn.set_sort_column_id(0)
    # Allow drag and drop reordering of rows
    self.chartTree.set_reorderable(True)
    scrolled_window = gtk.ScrolledWindow(hadjustment=None, vadjustment=None)
    scrolled_window.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
    scrolled_window.add_with_viewport(self.chartTree)
    
    return scrolled_window
    
  def loadChartData(self, store):
    filePath = os.path.join(self.path, self.chartFileName)
    infile = open(filePath, 'r')
    xmlData = ''
    for line in infile:
      xmlData += line
    dom1 = parseString(xmlData)
    
    chartLists = dom1.getElementsByTagName('chartList')
    for chartList in chartLists:
      listId = chartList.getElementsByTagName('listId')[0].childNodes[0].nodeValue
      listName = chartList.getElementsByTagName('listName')[0].childNodes[0].nodeValue
      piter = store.append(None, (listName, listId, ''))
      
      charts = chartList.getElementsByTagName('chart')
      for chart in charts:
        chartId = chart.getElementsByTagName('id')[0].childNodes[0].nodeValue
        chartName = chart.getElementsByTagName('name')[0].childNodes[0].nodeValue
        chartType = chart.getElementsByTagName('type')[0].childNodes[0].nodeValue
        store.append(piter, (chartName, chartId, chartType))
    return True    

  def initTopicTree(self):
    columnNames = [_('Name'), _('Id'), _('Type')]#, 'PicURL', 'Desc', 'Time'
    liststore = gtk.ListStore(str, str, str, str, str, str)
    # we'll add some data now - 4 rows with 3 child rows each
    self.loadTopicData(liststore)
    # create the TreeView using treestore
    self.topicTree = gtk.TreeView(liststore)
    # create the TreeViewColumn to display the data
    tvcolumn = [None] * len(columnNames)
    for n in range(0, len(columnNames)):
      cell = gtk.CellRendererText()
      tvcolumn[n] = gtk.TreeViewColumn(columnNames[n], cell)
      tvcolumn[n].add_attribute(cell, 'text', n)
      self.topicTree.append_column(tvcolumn[n])
    
    # make it searchable
    #self.treeview.set_search_column(0)
    # Allow sorting on the column
    #self.tvcolumn.set_sort_column_id(0)
    # Allow drag and drop reordering of rows
    self.topicTree.set_reorderable(True)
    scrolled_window = gtk.ScrolledWindow(hadjustment=None, vadjustment=None)
    scrolled_window.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
    scrolled_window.add_with_viewport(self.topicTree)
    scrolled_window.set_size_request(490, 500)
    vbox = gtk.VBox(spacing=5)
    vbox.pack_start(scrolled_window, True)
    vbox.pack_start(gtk.HSeparator(), False)
    
    sw = gtk.ScrolledWindow()
    sw.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
    textview = gtk.TextView()
    textview.props.editable = False
    textview.props.wrap_mode = gtk.WRAP_WORD
    textbuffer = textview.get_buffer()
    sw.add(textview)
    scrolled_window.set_size_request(-1, 50)
    hbox = gtk.HBox(spacing=5)
    hbox.pack_start(gtk.Label(_('Desc')), False)
    hbox.pack_start(sw, True)
    vbox.pack_start(hbox, False)
    
    picURLEntry = gtk.Entry(max=0)
    picURLEntry.props.editable = False
    hbox = gtk.HBox(spacing=5)
    hbox.pack_start(gtk.Label(_('PicURL')), False)
    hbox.pack_start(picURLEntry, True)
    vbox.pack_start(hbox, False)
    
    hbox = gtk.HBox(spacing=5)
    timeEntry = gtk.Entry(max=0)
    timeEntry.props.editable = False
    hbox.pack_start(gtk.Label(_('Time')), False)
    hbox.pack_start(timeEntry, True)
    vbox.pack_start(hbox, False)
    
    #self.topicTree.connect("row-activated", self.showRowDetail, textbuffer, picURLEntry, timeEntry)
    self.topicTree.connect("cursor_changed", self.showRowDetail, textbuffer, picURLEntry, timeEntry)
    return vbox
    
  def loadTopicData(self, store):
    filePath = os.path.join(self.path, self.topicFileName)
    infile = open(filePath, 'r')
    xmlData = ''
    for line in infile:
      xmlData += line
    dom1 = parseString(xmlData)
    
    chartLists = dom1.getElementsByTagName('chartList')
    for chartList in chartLists:
      listId = chartList.getElementsByTagName('listId')[0].childNodes[0].nodeValue
      listName = chartList.getElementsByTagName('listName')[0].childNodes[0].nodeValue
      #piter = store.append(None, (listName, listId, ''))
      
      charts = chartList.getElementsByTagName('chart')
      for chart in charts:
        chartId = chart.getElementsByTagName('id')[0].childNodes[0].nodeValue
        chartName = chart.getElementsByTagName('name')[0].childNodes[0].nodeValue
        chartType = chart.getElementsByTagName('type')[0].childNodes[0].nodeValue
        chartPicURL = chart.getElementsByTagName('picURL')[0].childNodes[0].nodeValue
        chartDesc = chart.getElementsByTagName('desc')[0].childNodes[0].nodeValue
        chartTime = chart.getElementsByTagName('time')[0].childNodes[0].nodeValue
        store.append([chartName, chartId, chartType, chartPicURL, chartDesc, chartTime])
    return True
    
  def showRowDetail(self, treeview, textbuffer, picURLEntry, timeEntry):
    (path, _) = treeview.get_cursor()
    model = treeview.get_model()
    iter = model.get_iter(path)
    picURL = model.get_value(iter, 3)
    desc = model.get_value(iter, 4)
    time = model.get_value(iter, 5)
    textbuffer.set_text(desc)
    picURLEntry.set_text(picURL)
    timeEntry.set_text(time)
    
gconf_keys = {  'listType' : '/apps/rhythmbox/plugins/onlinemusic/listType',
                'listId': '/apps/rhythmbox/plugins/onlinemusic/listId',
                'listName': '/apps/rhythmbox/plugins/onlinemusic/listName'
             }
class Preference(object):
  def __init__(self):
    self.gconf_keys = gconf_keys
    self.client = gconf.client_get_default()
    
  def set_values(self, listType, listId, listName):
    print listName
    self.client.set_string(self.gconf_keys['listType'], listType)
    self.client.set_string(self.gconf_keys['listId'], listId)
    self.client.set_string(self.gconf_keys['listName'], listName)
    return True
    
  def get_prefs (self):
    listType = self.client.get_string(self.gconf_keys['listType'])
    listId = self.client.get_string(self.gconf_keys['listId'])
    listName = self.client.get_string(self.gconf_keys['listName'])
    
    return (listType, listId, listName)
