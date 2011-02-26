"""
"""
from const import *
import container

class Table(container.Container):
    """A table style container.
    
    <p>If you know HTML, this should all work roughly how you would expect.  If you are not
    familiar with HTML, please read <a href="http://www.w3.org/TR/REC-html40/struct/tables.html">Tables in HTML Documents</a>.  Pay attention to TABLE, TR, TD related parts of the document.</p>
    
    <pre>Table()</pre>
    
    <strong>Example</strong>
    <code>
    t = gui.Table()
    
    t.tr()
    t.td(gui.Label("First Name"), align=-1)
    t.td(gui.Input())

    t.tr()
    t.td(gui.Label("Last Name"), align=-1)
    t.td(gui.Input())
    </code>
        
    """
    
    
    def __init__(self, **params):
        params.setdefault('cls','table')
        container.Container.__init__(self, **params)
        self._rows = []
        self._curRow = 0
        self._trok = False
        self._hpadding = params.get("hpadding", 0)
        self._vpadding = params.get("vpadding", 0)
    
    def getRows(self):
        return len(self._rows)
    
    def getColumns(self):
        if self._rows:
            return len(self._rows[0])
        else:
            return 0
    
    def remove_row(self, n): #NOTE: won't work in all cases.
        if n >= self.getRows():
            print "Trying to remove a nonexistant row:", n, "there are only", self.getRows(), "rows"
            return
        
        for cell in self._rows[n]:
            if isinstance(cell, dict) and cell["widget"] in self.widgets:
                #print 'removing widget'
                self.widgets.remove(cell["widget"])
        del self._rows[n]
        #print "got here"
        
        for w in self.widgets:
            if w.style.row > n: w.style.row -= 1
        
        if self._curRow >= n:
            self._curRow -= 1
        
        #self.rect.w, self.rect.h = self.resize()
        #self.repaint()
        
        self.chsize()
    
    def clear(self):
        self._rows = []
        self._curRow = 0
        self._trok = False

        self.widgets = []
        
        self.chsize()
        
        #print 'clear',self,self._rows
    
    def _addRow(self):
        self._rows.append([None for x in xrange(self.getColumns())])
    
    def tr(self):
        """Start on the next row."""
        if not self._trok:
            self._trok = True
            return 
        self._curRow += 1
        if self.getRows() <= self._curRow:
            self._addRow()
    
    def _addColumn(self):
        if not self._rows:
            self._addRow()
        for row in self._rows:
            row.append(None)
    
    def _setCell(self, w, col, row, colspan=1, rowspan=1):
        #make room for the widget by adding columns and rows
        while self.getColumns() < col + colspan:
            self._addColumn()
        while self.getRows() < row + rowspan:
            self._addRow()
            
        #print w.__class__.__name__,col,row,colspan,rowspan
        
        #actual widget setting and modification stuff
        w.container = self
        w.style.row = row #HACK - to work with gal's list
        w.style.col = col #HACK - to work with gal's list
        self._rows[row][col] = {"widget":w, "colspan":colspan, "rowspan":rowspan}
        self.widgets.append(self._rows[row][col]["widget"])
        
        #set the spanned columns
        #for acell in xrange(col + 1, col + colspan):
        #    self._rows[row][acell] = True
        
        #set the spanned rows and the columns on them
        #for arow in xrange(row + 1, row + rowspan):
        #    for acell in xrange(col, col + colspan): #incorrect?
        #        self._rows[arow][acell] = True
        
        for arow in xrange(row, row + rowspan):
            for acell in xrange(col, col + colspan): #incorrect?
                if row != arow or col != acell:
                    self._rows[arow][acell] = True
    
    
    def td(self, w, col=None, row=None, colspan=1, rowspan=1, **params):
        """Add a widget to a table after wrapping it in a TD container.
        
        <pre>Table.td(w,col=None,row=None,colspan=1,rowspan=1,**params)</pre>
        
        <dl>
        <dt>w<dd>widget
        <dt>col<dd>column
        <dt>row<dd>row
        <dt>colspan<dd>colspan
        <dt>rowspan<dd>rowspan
        <dt>align<dd>horizontal alignment (-1,0,1)
        <dt>valign<dd>vertical alignment (-1,0,1)
        <dt>params<dd>other params for the TD container, style information, etc
        </dl>
        """
        
        Table.add(self,_Table_td(w, **params), col=col, row=row, colspan=colspan, rowspan=rowspan)
    
    def add(self, w, col=None, row=None, colspan=1, rowspan=1):
        """Add a widget directly into the table, without wrapping it in a TD container.
        
        <pre>Table.add(w,col=None,row=None,colspan=1,rowspan=1)</pre>
        
        <p>See Table.td for an explanation of the parameters.</p>
        """
        self._trok = True
        #if no row was specifically specified, set it to the current row
        if row is None:
            row = self._curRow
            #print row
        
        #if its going to be a new row, have it be on the first column
        if row >= self.getRows():
            col = 0
        
        #try to find an open cell for the widget
        if col is None:
            for cell in xrange(self.getColumns()):
                if col is None and not self._rows[row][cell]:
                    col = cell
                    break
        
        #otherwise put the widget in a new column
        if col is None:
            col = self.getColumns()
        
        self._setCell(w, col, row, colspan=colspan, rowspan=rowspan)
        
        self.chsize()
        return
        
    def remove(self,w):
        if hasattr(w,'_table_td'): w = w._table_td
        row,col = w.style.row,w.style.col
        cell = self._rows[row][col]
        colspan,rowspan = cell['colspan'],cell['rowspan']
        
        for arow in xrange(row , row + rowspan):
            for acell in xrange(col, col + colspan): #incorrect?
                self._rows[arow][acell] = False
        self.widgets.remove(w)
        self.chsize()
        
        
    
    def resize(self, width=None, height=None):
        #if 1 or self.getRows() == 82:
            #print ''
            #print 'resize',self.getRows(),self.getColumns(),width,height
            #import inspect
            #for obj,fname,line,fnc,code,n in inspect.stack()[9:20]:
            #    print fname,line,':',fnc,code[0].strip()

        
        #resize the widgets to their smallest size
        for w in self.widgets:
            w.rect.w, w.rect.h = w.resize()
        
        #calculate row heights and column widths
        rowsizes = [0 for y in xrange(self.getRows())]
        columnsizes = [0 for x in xrange(self.getColumns())]
        for row in xrange(self.getRows()):
            for cell in xrange(self.getColumns()):
                if self._rows[row][cell] and self._rows[row][cell] is not True:
                    if not self._rows[row][cell]["colspan"] > 1:
                        columnsizes[cell] = max(columnsizes[cell], self._rows[row][cell]["widget"].rect.w)
                    if not self._rows[row][cell]["rowspan"] > 1:
                        rowsizes[row] = max(rowsizes[row], self._rows[row][cell]["widget"].rect.h)
        
        #distribute extra space if necessary for wide colspanning/rowspanning
        for row in xrange(self.getRows()):
            for cell in xrange(self.getColumns()):
                if self._rows[row][cell] and self._rows[row][cell] is not True:
                    if self._rows[row][cell]["colspan"] > 1:
                        columns = xrange(cell, cell + self._rows[row][cell]["colspan"])
                        totalwidth = 0
                        for acol in columns:
                            totalwidth += columnsizes[acol]
                        if totalwidth < self._rows[row][cell]["widget"].rect.w:
                            for acol in columns:
                                columnsizes[acol] += _table_div(self._rows[row][cell]["widget"].rect.w - totalwidth, self._rows[row][cell]["colspan"],acol)
                    if self._rows[row][cell]["rowspan"] > 1:
                        rows = xrange(row, row + self._rows[row][cell]["rowspan"])
                        totalheight = 0
                        for arow in rows:
                            totalheight += rowsizes[arow]
                        if totalheight < self._rows[row][cell]["widget"].rect.h:
                            for arow in rows:
                                rowsizes[arow] += _table_div(self._rows[row][cell]["widget"].rect.h - totalheight, self._rows[row][cell]["rowspan"],arow)

        rowsizes = [sz+2*self._vpadding for sz in rowsizes]
        columnsizes = [sz+2*self._hpadding for sz in columnsizes]

        #make everything fill out to self.style.width, self.style.heigh, not exact, but pretty close...
        w, h = sum(columnsizes), sum(rowsizes)
        if w > 0 and w < self.style.width and len(columnsizes):
            d = (self.style.width - w) 
            for n in xrange(0, len(columnsizes)):
                v = columnsizes[n]
                columnsizes[n] += v * d / w
        if h > 0 and h < self.style.height and len(rowsizes):
            d = (self.style.height - h) / len(rowsizes)
            for n in xrange(0, len(rowsizes)):
                v = rowsizes[n]
                rowsizes[n] += v * d / h
        
        #set the widget's position by calculating their row/column x/y offset
        cellpositions = [[[sum(columnsizes[0:cell]), sum(rowsizes[0:row])] for cell in xrange(self.getColumns())] for row in xrange(self.getRows())]
        for row in xrange(self.getRows()):
            for cell in xrange(self.getColumns()):
                if self._rows[row][cell] and self._rows[row][cell] is not True:
                    x, y = cellpositions[row][cell]
                    w = sum(columnsizes[cell:cell+self._rows[row][cell]["colspan"]])
                    h = sum(rowsizes[row:row+self._rows[row][cell]["rowspan"]])
                    
                    widget = self._rows[row][cell]["widget"]
                    widget.rect.x = x
                    widget.rect.y = y
                    if 1 and (w,h) != (widget.rect.w,widget.rect.h):
#                         if h > 20:
#                             print widget.widget.__class__.__name__, (widget.rect.w,widget.rect.h),'=>',(w,h)
                        widget.rect.w, widget.rect.h = widget.resize(w, h)
                    
                    #print self._rows[row][cell]["widget"].rect
        
        #print columnsizes
        #print sum(columnsizes)
        #size = sum(columnsizes), sum(rowsizes); print size
        
        #return the tables final size
        return sum(columnsizes),sum(rowsizes)

        
def _table_div(a,b,c):
    v,r = a/b, a%b
    if r != 0 and (c%b)<r: v += 1
    return v

class _Table_td(container.Container):
    def __init__(self,widget,**params):#hexpand=0,vexpand=0,
        container.Container.__init__(self,**params)
        self.widget = widget
        #self.hexpand=hexpand
        #self.vexpand=vexpand
        widget._table_td = self
        self.add(widget,0,0)
    
    def resize(self,width=None,height=None):
        w = self.widget
        
        #expansion code, but i didn't like the idea that much..
        #a bit obscure, fairly useless when a user can just
        #add a widget to a table instead of td it in.
        #ww,hh=None,None
        #if self.hexpand: ww = self.style.width
        #if self.vexpand: hh = self.style.height
        #if self.hexpand and width != None: ww = max(ww,width)
        #if self.vexpand and height != None: hh = max(hh,height)
        #w.rect.w,w.rect.h = w.resize(ww,hh)
        
        #why bother, just do the lower mentioned item...
        w.rect.w,w.rect.h = w.resize()
        
        #this should not be needed, widgets should obey their sizing on their own.
        
#         if (self.style.width!=0 and w.rect.w > self.style.width) or (self.style.height!=0 and w.rect.h > self.style.height):
#             ww,hh = None,None
#             if self.style.width: ww = self.style.width
#             if self.style.height: hh = self.style.height
#             w.rect.w,w.rect.h = w.resize(ww,hh)
      
  
        #in the case that the widget is too big, we try to resize it
        if (width != None and width < w.rect.w) or (height != None and height < w.rect.h):
            w.rect.w,w.rect.h = w.resize(width,height)
        
        width = max(width,w.rect.w,self.style.width) #,self.style.cell_width)
        height = max(height,w.rect.h,self.style.height) #,self.style.cell_height)
        
        dx = width-w.rect.w
        dy = height-w.rect.h
        w.rect.x = (self.style.align+1)*dx/2
        w.rect.y = (self.style.valign+1)*dy/2
        
        return width,height
