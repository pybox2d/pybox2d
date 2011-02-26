"""
"""

from pygame.locals import *

from const import *
import widget, surface
import basic

class _button(widget.Widget):
    def __init__(self,**params):
        widget.Widget.__init__(self,**params)
        self.state = 0
    
    def event(self,e):
        if e.type == ENTER: self.repaint()
        elif e.type == EXIT: self.repaint()
        elif e.type == FOCUS: self.repaint()
        elif e.type == BLUR: self.repaint()
        elif e.type == KEYDOWN:
            if e.key == K_SPACE or e.key == K_RETURN:
                self.state = 1
                self.repaint()
        elif e.type == MOUSEBUTTONDOWN: 
            self.state = 1
            self.repaint()
        elif e.type == KEYUP:
            if self.state == 1:
                sub = pygame.event.Event(CLICK,{'pos':(0,0),'button':1})
                #self.send(sub.type,sub)
                self._event(sub)
            
            self.state = 0
            self.repaint()
        elif e.type == MOUSEBUTTONUP:
            self.state = 0
            self.repaint()
        elif e.type == CLICK:
            self.click()
        
        self.pcls = ""
        if self.state == 0 and self.is_hovering():
            self.pcls = "hover"
        if self.state == 1 and self.is_hovering():
            self.pcls = "down"
    
    def click(self): 
        pass


class Button(_button):
    """A button, buttons can be clicked, they are usually used to set up callbacks.
    
    <pre>Button(value=None)</pre>
    
    <dl>
    <dt>value<dd>either a widget or a string
    </dl>
    
    <strong>Example</strong>
    <code>
    w = gui.Button("Click Me")
    w.connect(gui.CLICK,fnc,value)
    </code>
    """
    def __init__(self,value=None,**params):
        params.setdefault('cls','button')
        _button.__init__(self,**params)
        self.value = value
    
    def __setattr__(self,k,v):
        if k == 'value' and type(v) == str: v = basic.Label(v,cls=self.cls+".label")
        _v = self.__dict__.get(k,NOATTR)
        self.__dict__[k]=v
        if k == 'value' and v != None:
            pass
        
        if k == 'value' and _v != NOATTR and _v != None and _v != v:
            self.send(CHANGE)
            self.chsize()
    
    def resize(self,width=None,height=None):
        self.value.rect.x,self.value.rect.y = 0,0
        self.value.rect.w,self.value.rect.h = self.value.resize(width,height)
        return self.value.rect.w,self.value.rect.h
#         
#         self.value._resize()
#         self.rect.w,self.rect.h = self.value.rect_margin.w,self.value.rect_margin.h
#         
#         if self.style.width: self.rect.w = max(self.rect.w,self.style.width)
#         if self.style.height: self.rect.w = max(self.rect.w,self.style.height)
#         
#         xt,xr,xb,xl = self.value.getspacing()
#         
#         self.value._resize(self.rect.w-(xl+xr),self.rect.h-(xt+xb))
#     
    def paint(self,s):
        self.value.pcls = self.pcls
        self.value.paint(surface.subsurface(s,self.value.rect))

class Switch(_button):
    """A switch can have two states, True or False.
    
    <pre>Switch(value=False)</pre>
    
    <dl>
    <dt>value<dd>initial value, (True, False)
    </dl>
    
    <strong>Example</strong>
    <code>
    w = gui.Switch(True)
    w.connect(gui.CHANGE,fnc,value)
    </code>
    """
    def __init__(self,value=False,**params):
        params.setdefault('cls','switch')
        _button.__init__(self,**params)
        self.value = value
        
        img = self.style.off
        self.style.width = img.get_width()
        self.style.height = img.get_height()
    
    def paint(self,s):
        #self.pcls = ""
        #if self.container.myhover is self: self.pcls = "hover"
        if self.value: img = self.style.on
        else: img = self.style.off
        s.blit(img,(0,0))
    
    def __setattr__(self,k,v):
        _v = self.__dict__.get(k,NOATTR)
        self.__dict__[k]=v
        if k == 'value' and _v != NOATTR and _v != v: 
            self.send(CHANGE)
            self.repaint()
    
    def click(self):
        self.value = not self.value

class Checkbox(_button):    
    """Within a Group of Checkbox widgets several may be selected at a time.
    
    <pre>Checkbox(group,value=None)</pre>
    
    <dl>
    <dt>group<dd>a gui.Group for the Checkbox to belong to
    <dt>value<dd>the value
    </dl>
    
    <strong>Example</strong>
    <code>
    g = gui.Group(name='colors',value=['r','b'])
    
    t = gui.Table()
    t.tr()
    t.td(gui.Label('Red'))
    t.td(gui.Checkbox(g,'r'))
    t.tr()
    t.td(gui.Label('Green'))
    t.td(gui.Checkbox(g,'g'))
    t.tr()
    t.td(gui.Label('Blue'))
    t.td(gui.Checkbox(g,'b'))
    </code>
    """
    
    def __init__(self,group,value=None,**params):
        params.setdefault('cls','checkbox')
        _button.__init__(self,**params)
        self.group = group
        self.group.add(self)
        if self.group.value == None:
            self.group.value = []
        self.value = value
        
        img = self.style.off
        self.style.width = img.get_width()
        self.style.height = img.get_height()
    
    def paint(self,s):
        #self.pcls = ""
        #if self.container.myhover is self: self.pcls = "hover"
        if self.value in self.group.value: img = self.style.on
        else: img = self.style.off
        
        s.blit(img,(0,0))
    
    def click(self):
        if self.value in self.group.value:
            self.group.value.remove(self.value)
        else:
            self.group.value.append(self.value)
        self.group._change()

class Radio(_button):
    """Within a Group of Radio widgets only one may be selected at a time.
    
    <pre>Radio(group,value=None)</pre>
    
    <dl>
    <dt>group<dd>a gui.Group for the Radio to belong to
    <dt>value<dd>the value
    </dl>
    
    <strong>Example</strong>
    <code>
    g = gui.Group(name='colors',value='g')
    
    t = gui.Table()
    t.tr()
    t.td(gui.Label('Red'))
    t.td(gui.Radio(g,'r'))
    t.tr()
    t.td(gui.Label('Green'))
    t.td(gui.Radio(g,'g'))
    t.tr()
    t.td(gui.Label('Blue'))
    t.td(gui.Radio(g,'b'))
    </code>
    """
    
    
    def __init__(self,group=None,value=None,**params):
        params.setdefault('cls','radio')
        _button.__init__(self,**params)
        self.group = group
        self.group.add(self)
        self.value = value
        
        img = self.style.off
        self.style.width = img.get_width()
        self.style.height = img.get_height()
    
    def paint(self,s):
        #self.pcls = ""
        #if self.container.myhover is self: self.pcls = "hover"
        if self.group.value == self.value: img = self.style.on
        else: img = self.style.off
        s.blit(img,(0,0))
    
    def click(self):
        self.group.value = self.value

class Tool(_button):
    """Within a Group of Tool widgets only one may be selected at a time.
    
    <pre>Tool(group,widget=None,value=None)</pre>
    
    <dl>
    <dt>group<dd>a gui.Group for the Tool to belong to
    <dt>widget<dd>a widget to appear on the Tool (similar to a Button)
    <dt>value<dd>the value
    </dl>
    
    <strong>Example</strong>
    <code>
    g = gui.Group(name='colors',value='g')
    
    t = gui.Table()
    t.tr()
    t.td(gui.Tool(g,'Red','r'))
    t.tr()
    t.td(gui.Tool(g,'Green','g'))
    t.tr()
    t.td(gui.Tool(g,'Blue','b'))
    </code>
    """

    def __init__(self,group,widget=None,value=None,**params): #TODO widget= could conflict with module widget
        params.setdefault('cls','tool')
        _button.__init__(self,**params)
        self.group = group
        self.group.add(self)
        self.value = value
        
        if widget:
            self.setwidget(widget)
        
        if self.group.value == self.value: self.pcls = "down"
    
    def setwidget(self,w):
        self.widget = w
    
    def resize(self,width=None,height=None):
        self.widget.rect.w,self.widget.rect.h = self.widget.resize()
        #self.widget._resize()
        #self.rect.w,self.rect.h = self.widget.rect_margin.w,self.widget.rect_margin.h
        
        return self.widget.rect.w,self.widget.rect.h
    
    def event(self,e):
        _button.event(self,e)
        if self.group.value == self.value: self.pcls = "down"
    
    def paint(self,s):
        if self.group.value == self.value: self.pcls = "down"
        self.widget.paint(surface.subsurface(s,self.widget.rect))
    
    def click(self):
        self.group.value = self.value
        for w in self.group.widgets:
            if w != self: w.pcls = ""

            
class Icon(_button):
    """TODO - might be deprecated
    """
    def __init__(self,cls,**params):
        params['cls'] = cls
        _button.__init__(self,**params)
        s = self.style.image
        self.style.width = s.get_width()
        self.style.height = s.get_height()
        self.state = 0
    
    def paint(self,s):
        #self.pcls = ""
        #if self.state == 0 and hasattr(self.container,'myhover') and self.container.myhover is self: self.pcls = "hover"
        #if self.state == 1 and hasattr(self.container,'myhover') and self.container.myhover is self: self.pcls = "down"
        s.blit(self.style.image,(0,0))

class Link(_button):
    """A link, links can be clicked, they are usually used to set up callbacks.  
    Basically the same as the button widget, just text only with a different cls.  Made for
    convenience.
    
    <pre>Link(value=None)</pre>
    
    <dl>
    <dt>value<dd>a string
    </dl>
    
    <strong>Example</strong>
    <code>
    w = gui.Link("Click Me")
    w.connect(gui.CLICK,fnc,value)
    </code>
    """
    def __init__(self,value,**params):
        params.setdefault('focusable',True)
        params.setdefault('cls','link')
        _button.__init__(self,**params)
        self.value = value
        self.font = self.style.font
        self.style.width, self.style.height = self.font.size(self.value)
    
    def paint(self,s):
        s.blit(self.font.render(self.value, 1, self.style.color),(0,0))

