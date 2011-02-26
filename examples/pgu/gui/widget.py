"""
"""
import pygame

import pguglobals
import style

class SignalCallback:
    # The function to call
    func = None
    # The parameters to pass to the function (as a list)
    params = None

class Widget:
    """Template object - base for all widgets.
    
    <pre>Widget(**params)</pre>
    
    <p>A number of optional params may be passed to the Widget initializer.</p>
    
    <dl>
    <dt>decorate<dd>defaults to True.  If true, will call <tt>theme.decorate(self)</tt> to allow the theme a chance to decorate the widget.
    <dt>style<dd>a dict of style parameters.
    <dt>x, y, width, height<dd>position and size parameters, passed along to style
    <dt>align, valign<dd>alignment parameters, passed along to style
    <dt>font, color, background<dd>other common parameters that are passed along to style
    <dt>cls<dd>class name as used by Theme
    <dt>name<dd>name of widget as used by Form.  If set, will call <tt>form.add(self,name)</tt> to add the widget to the most recently created Form.
    <dt>focusable<dd>True if this widget can receive focus via Tab, etc.  Defaults to True.
    <dt>disabled<dd>True of this widget is disabled.  Defaults to False.
    <dt>value<dd>initial value
    </dl>
    
    <strong>Example - Creating your own Widget</strong>
    <p>This example shows which methods are template methods.</p>
    <code>
    class Draw(gui.Widget):
        def paint(self,s):
            #paint the pygame.Surface
            return
        
        def update(self,s):
            #update the pygame.Surface and return the update rects
            return [pygame.Rect(0,0,self.rect.w,self.rect.h)]
            
        def event(self,e):
            #handle the pygame.Event
            return
            
        def resize(self,width=None,height=None):
            #return the width and height of this widget
            return 256,256
    </code>
    """

    # The name of the widget (or None if not defined)
    name = None
    # The container this widget belongs to
    container = None
    # Whether this widget has been painted yet
    _painted = False
    # The widget used to paint the background
    background = None
    # ...
    _rect_content = None
    
    def __init__(self,**params): 
        #object.Object.__init__(self) 
        self.connects = {}
        params.setdefault('decorate',True)
        params.setdefault('style',{})
        params.setdefault('focusable',True)
        params.setdefault('disabled',False)
        
        self.focusable = params['focusable']
        self.disabled = params['disabled']
        
        self.rect = pygame.Rect(params.get('x',0),
                                params.get('y',0),
                                params.get('width',0),
                                params.get('height',0))
        
        s = params['style']
        #some of this is a bit "theme-ish" but it is very handy, so these
        #things don't have to be put directly into the style.
        for att in ('align','valign','x','y','width','height','color','font','background'):
            if att in params: s[att] = params[att]
        self.style = style.Style(self,s)
        
        self.cls = 'default'
        if 'cls' in params: self.cls = params['cls']
        if 'name' in params:    
            import form
            self.name = params['name']
            if form.Form.form:
                form.Form.form.add(self)
                self.form = form.Form.form
        if 'value' in params: self.value = params['value']
        self.pcls = ""
        
        if params['decorate'] != False:
            if (not pguglobals.app):
                # TODO - fix this somehow
                import app
                app.App()
            pguglobals.app.theme.decorate(self,params['decorate'])

    def focus(self):
        """Focus this Widget.
        
        <pre>Widget.focus()</pre>
        """
        if self.container: 
            if self.container.myfocus != self:  ## by Gal Koren
                self.container.focus(self)

    def blur(self): 
        """Blur this Widget.
        
        <pre>Widget.blur()</pre>
        """
        if self.container: self.container.blur(self)

    def open(self):
        """Open this Widget as a modal dialog.
        
        <pre>Widget.open()</pre>
        """
        #if getattr(self,'container',None) != None: self.container.open(self)
        pguglobals.app.open(self)

    def close(self, w=None):
        """Close this Widget (if it is a modal dialog.)
        
        <pre>Widget.close()</pre>
        """
        #if getattr(self,'container',None) != None: self.container.close(self)
        if (not w):
            w = self
        pguglobals.app.close(w)

    def is_open(self):
        return (self in pguglobals.app.windows)

    # Returns true if the mouse is hovering over this widget
    def is_hovering(self):
        if self.container:
            return (self.container.myhover is self)
        return False

    def resize(self,width=None,height=None):
        """Template method - return the size and width of this widget.

        <p>Responsible for also resizing all sub-widgets.</p>
                
        <pre>Widget.resize(width,height): return width,height</pre>
        
        <dl>
        <dt>width<dd>suggested width
        <dt>height<dd>suggested height
        </dl>
        
        <p>If not overridden, will return self.style.width, self.style.height</p>
        """
        return self.style.width, self.style.height

    def chsize(self):
        """Change the size of this widget.
        
        <p>Calling this method will cause a resize on all the widgets,
        including this one.</p>
        
        <pre>Widget.chsize()</pre>
        """
        
        if (not self._painted): return
        
        if (not self.container): return
        
        if pguglobals.app:
            if pguglobals.app._chsize:
                return
            pguglobals.app.chsize()
            return
            
        #if hasattr(app.App,'app'):
        #    w,h = self.rect.w,self.rect.h
        #    w2,h2 = self.resize()
        #    if w2 != w or h2 != h:
        #        app.App.app.chsize()
        #    else: 
        #        self.repaint()
        

    def update(self,s):
        """Template method - update the surface
        
        <pre>Widget.update(s): return list of pygame.Rect(s)</pre>
        
        <dl>
        <dt>s<dd>pygame.Surface to update
        </dl>
        
        <p>return - a list of the updated areas as pygame.Rect(s).</p>
        """
        return
        
    def paint(self,s):
        """Template method - paint the surface
        
        <pre>Widget.paint(s)</pre>
        
        <dl>
        <dt>s<dd>pygame.Surface to paint
        </dl>
        """
        return

    def repaint(self): 
        """Request a repaint of this Widget.
        
        <pre>Widget.repaint()</pre>
        """
        if self.container: self.container.repaint(self)

    def repaintall(self):
        """Request a repaint of all Widgets.
        
        <pre>Widget.repaintall()</pre>
        """
        if self.container: self.container.repaintall()

    def reupdate(self): 
        """Request a reupdate of this Widget
        
        <pre>Widget.reupdate()</pre>
        """
        if self.container: self.container.reupdate(self)

    def next(self): 
        """Pass focus to next Widget.
        
        <p>Widget order determined by the order they were added to their container.</p>
        
        <pre>Widget.next()</pre>
        """
        if self.container: self.container.next(self)

    def previous(self): 
        """Pass focus to previous Widget.
        
        <p>Widget order determined by the order they were added to their container.</p>
        
        <pre>Widget.previous()</pre>
        """
        
        if self.container: self.container.previous(self)
    
    def get_abs_rect(self):
        """Get the absolute rect of this widget on the App screen
        
        <pre>Widget.get_abs_rect(): return pygame.Rect</pre>
        """
        x, y = self.rect.x, self.rect.y
        x += self._rect_content.x
        y += self._rect_content.y
        cnt = self.container
        while cnt:
            x += cnt.rect.x
            y += cnt.rect.y
            if cnt._rect_content:
                x += cnt._rect_content.x
                y += cnt._rect_content.y
            cnt = cnt.container
        return pygame.Rect(x, y, self.rect.w, self.rect.h)

    def connect(self,code,func,*params):
        """Connect a event code to a callback function.
        
        <p>There may be multiple callbacks per event code.</p>
        
        <pre>Object.connect(code,fnc,value)</pre>
        
        <dl>
        <dt>code<dd>event type [[gui-const]]
        <dt>fnc<dd>callback function
        <dt>*values<dd>values to pass to callback.  Please note that callbacks may also have "magicaly" parameters.  Such as:
            <dl>
            <dt>_event<dd>receive the event
            <dt>_code<dd>receive the event code
            <dt>_widget<dd>receive the sending widget
            </dl>
        </dl>
        
        <strong>Example</strong>
        <code>
        def onclick(value):
            print 'click',value
        
        w = Button("PGU!")
        w.connect(gui.CLICK,onclick,'PGU Button Clicked')
        </code>
        """
        if (not code in self.connects):
            self.connects[code] = []
        for cb in self.connects[code]:
            if (cb.func == func):
                # Already connected to this callback function
                return
        # Wrap the callback function and add it to the list
        cb = SignalCallback()
        cb.func = func
        cb.params = params
        self.connects[code].append(cb)

    # Remove signal handlers from the given event code. If func is specified,
    # only those handlers will be removed. If func is None, all handlers
    # will be removed.
    def disconnect(self, code, func=None):
        if (not code in self.connects):
            return
        if (not func):
            # Remove all signal handlers
            del self.connects[code]
        else:
            # Remove handlers that call 'func'
            n = 0
            callbacks = self.connects[code]
            while (n < len(callbacks)):
                if (callbacks[n].func == func):
                    # Remove this callback
                    del callbacks[n]
                else:
                    n += 1

    def send(self,code,event=None):
        """Send a code, event callback trigger.
        
        <pre>Object.send(code,event=None)</pre>
        
        <dl>
        <dt>code<dd>event code
        <dt>event<dd>event
        </dl>
        """
        if (not code in self.connects):
            return
        # Trigger all connected signal handlers
        for cb in self.connects[code]:
            func = cb.func
            values = list(cb.params)

            nargs = func.func_code.co_argcount
            names = list(func.func_code.co_varnames)[:nargs]
            if hasattr(func,'im_class'): names.pop(0)
            
            args = []
            magic = {'_event':event,'_code':code,'_widget':self}
            for name in names:
                if name in magic.keys():
                    args.append(magic[name])
                elif len(values):
                    args.append(values.pop(0))
                else:
                    break
            args.extend(values)
            func(*args)
    
    def _event(self,e):
        if self.disabled: return
        self.send(e.type,e)
        return self.event(e)
        
    def event(self,e):
        """Template method - called when an event is passed to this object.
        
        <p>Please note that if you use an event, returning the value True
        will stop parent containers from also using the event.  (For example, if
        your widget handles TABs or arrow keys, and you don't want those to 
        also alter the focus.)</p>
        
        <dl>
        <dt>e<dd>event
        </dl>
        """
        
        return

    # Returns the top-level widget (usually the Desktop) by following the
    # chain of 'container' references.
    def get_toplevel(self):
        top = self
        while (top.container):
            top = top.container
        return top

    # Test if the given point hits this widget. Over-ride this function
    # for more advanced collision testing.
    def collidepoint(self, pos):
        return self.rect.collidepoint(pos)

