"""
"""
import pygame
from pygame.locals import *

import pguglobals
import container
from const import *

class App(container.Container):
    """The top-level widget for an application.
    
    <pre>App(theme=None)</pre>
    
    <dl>
    <dt>theme<dd>an instance of a Theme, optional as it will use the default Theme class.
    </dl>
    
    <strong>Basic Example</strong>
    <code>
    app = gui.App()
    app.run(widget=widget,screen=screen)
    </code>
    
    <strong>Integrated Example</strong>
    <code>
    app = gui.App()
    gui.init(widget=widget)
    while 1:
        for e in pygame.event.get():
            app.event(e)
        app.update(screen)
    </code>
    """

    # The top-level widget in the application
    widget = None
    # The pygame display for rendering the GUI. Note this may be a subsurface
    # of the full surface.
    screen = None
    # The region of the (full) pygame display that contains the GUI. If set,
    # this is used when transforming the mouse position from screen 
    # coordinates into the subsurface coordinates.
    appArea = None

    def __init__(self,theme=None,**params):
        self.set_global_app()

        if theme == None: 
            from theme import Theme
            theme = Theme()
        self.theme = theme
        
        params['decorate'] = 'app'
        container.Container.__init__(self,**params)
        self._quit = False
        self.widget = None
        self._chsize = False
        self._repaint = False
        
        self.screen = None
        self.container = None

    def set_global_app(self):
        # Keep a global reference to this application instance so that PGU
        # components can easily find it.
        pguglobals.app = self
        # For backwards compatibility we keep a reference in the class 
        # itself too.
        App.app = self
        
    def resize(self):
        if self.screen:
            # The user has explicitly specified a screen surface
            size = self.screen.get_size()

        elif pygame.display.get_surface():
            # Use the existing pygame display
            self.screen = pygame.display.get_surface()
            size = self.screen.get_size()

        else:
            # Otherwise we must allocate a new pygame display
            if self.style.width != 0 and self.style.height != 0:
                # Create a new screen based on the desired app size
                size = (self.style.width, self.style.height)
        
            else:
                # Use the size of the top-most widget
                size = self.widget.rect.size = self.widget.resize()
            # Create the display
            self.screen = pygame.display.set_mode(size, SWSURFACE)

        #use screen to set up size of this widget
        self.style.width,self.style.height = size
        self.rect.size = size
        self.rect.topleft = (0, 0)
        
        self.widget.rect.topleft = (0, 0)
        self.widget.rect.size = self.widget.resize(*size)

        for w in self.windows:
            w.rect.size = w.resize()

        self._chsize = False

    
    def init(self, widget=None, screen=None, area=None):
        """Initialize the application.

        Keyword arguments:
        widget -- the top-level widget
        screen -- the pygame.Surface to render to
        area -- the rectangle (within 'screen') to use for rendering
        """

        self.set_global_app()
        
        if (widget): 
            # Set the top-level widget
            self.widget = widget
        if (screen): 
            if (area):
                # Take a subsurface of the given screen
                self.appArea = area
                self.screen = screen.subsurface(area)
            else:
                # Use the entire screen for the app
                self.screen = screen
        
        self.resize()   
        
        w = self.widget     
        
        self.widgets = []
        self.widgets.append(w)
        w.container = self
        self.focus(w)
        
        pygame.key.set_repeat(500,30)
        
        self._repaint = True
        self._quit = False
        
        self.send(INIT)
    
    def event(self,ev):
        """Pass an event to the main widget.
        
        <pre>App.event(e)</pre>
        
        <dl>
        <dt>e<dd>event
        </dl>
        """
        self.set_global_app()

        if (self.appArea and hasattr(ev, "pos")):
            # Translate into subsurface coordinates
            pos = (ev.pos[0]-self.appArea.x,
                   ev.pos[1]-self.appArea.y)
            args = {"pos" : pos}
            # Copy over other misc mouse parameters
            for name in ("buttons", "rel", "button"):
                if (hasattr(ev, name)):
                    args[name] = getattr(ev, name)
            
            ev = pygame.event.Event(ev.type, args)

        #NOTE: might want to deal with ACTIVEEVENT in the future.
        self.send(ev.type, ev)
        container.Container.event(self, ev)
        if ev.type == MOUSEBUTTONUP:
            if ev.button not in (4,5): # Ignores the mouse wheel
                # Also issue a "CLICK" event
                sub = pygame.event.Event(CLICK,{
                    'button' : ev.button,
                    'pos' : ev.pos})
                self.send(sub.type,sub)
                container.Container.event(self,sub)
    
    def loop(self):
        self.set_global_app()

        for e in pygame.event.get():
            if not (e.type == QUIT and self.mywindow):
                self.event(e)
        rects = self.update(self.screen)
        pygame.display.update(rects)
        
        
    def paint(self,screen=None):
        if (screen):
            self.screen = screen

        if self._chsize:
            self._chsize = False
            self.resize()

        if self.background:
            self.background.paint(self.screen)

        container.Container.paint(self, self.screen)

    def update(self,screen=None):
        """Update the screen.
        
        <dl>
        <dt>screen<dd>pygame surface
        </dl>
        """
        if (screen):
            self.screen = screen

        if self._chsize:
            self.resize()
            self._chsize = False
            return None

        if self._repaint:
            self.paint(self.screen)
            self._repaint = False
            rects = [pygame.Rect(0, 0,
                                 self.screen.get_width(),
                                 self.screen.get_height())]
        else:
            rects = container.Container.update(self,self.screen)

        if (self.appArea):
            # Translate the rects from subsurface coordinates into
            # full display coordinates.
            for r in rects:
                r.move_ip(self.appArea.topleft)

        return rects
    
    def run(self,widget=None,screen=None): 
        """Run an application.
        
        <p>Automatically calls <tt>App.init</tt> and then forever loops <tt>App.event</tt> and <tt>App.update</tt></p>
        
        <dl>
        <dt>widget<dd>main widget
        <dt>screen<dd>pygame.Surface to render to
        </dl>
        """
        self.init(widget,screen)
        while not self._quit:
            self.loop()
            pygame.time.wait(10)
    
    def reupdate(self,w=None): pass
    def repaint(self,w=None): self._repaint = True
    def repaintall(self): self._repaint = True
    def chsize(self):
        self._chsize = True
        self._repaint = True
    
    def quit(self,value=None): self._quit = True

    def open(self, w, pos=None):
        w.container = self
        
        if (w.rect.w == 0 or w.rect.h == 0):
            w.rect.size = w.resize()
        
        if (not pos): 
            # Auto-center the window
            w.rect.center = self.rect.center
        else: 
            # Show the window in a particular location
            w.rect.topleft = pos
        
        self.windows.append(w)
        self.mywindow = w
        self.focus(w)
        self.repaint(w)
        w.send(OPEN)

    def close(self, w):
        if self.myfocus is w: self.blur(w)

        if w not in self.windows: return #no need to remove it twice! happens.
        
        self.windows.remove(w)
        
        self.mywindow = None
        if self.windows:
            self.mywindow = self.windows[-1]
            self.focus(self.mywindow)
        
        if not self.mywindow:
            self.myfocus = self.widget #HACK: should be done fancier, i think..
            if not self.myhover:
                self.enter(self.widget)
         
        self.repaintall()
        w.send(CLOSE)


class Desktop(App):
    """Create an App using the <tt>desktop</tt> theme class.
    
    <pre>Desktop()</pre>
    """
    def __init__(self,**params):
        params.setdefault('cls','desktop')
        App.__init__(self,**params)
