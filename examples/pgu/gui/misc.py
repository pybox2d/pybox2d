from const import *
import widget
import pguglobals

class ProgressBar(widget.Widget):
    """A progress bar.
    
    <pre>ProgressBar(value,min,max)</pre>
    
    <dl>
    <dt>value<dd>starting value
    <dt>min<dd>minimum value rendered on the screen (usually 0)
    <dt>max<dd>maximum value
    </dl>
    
    <strong>Example</strong>
    <code>
    w = gui.ProgressBar(0,0,100)
    w.value = 25
    </code>
    """

    def __init__(self,value,min,max,**params):
        params.setdefault('cls','progressbar')
        widget.Widget.__init__(self,**params)
        self.min,self.max,self.value = min,max,value
    
    def paint(self,s):
        r = pygame.rect.Rect(0,0,self.rect.w,self.rect.h)
        r.w = r.w*(self.value-self.min)/(self.max-self.min)
        self.bar = r
        pguglobals.app.theme.render(s,self.style.bar,r)
        
    def __setattr__(self,k,v):
        if k == 'value':
            v = int(v)
            v = max(v,self.min)
            v = min(v,self.max)
        _v = self.__dict__.get(k,NOATTR)
        self.__dict__[k]=v
        if k == 'value' and _v != NOATTR and _v != v: 
            self.send(CHANGE)
            self.repaint()
