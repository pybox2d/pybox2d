"""
"""
import pygame

def subsurface(s,r):
    """Return the subsurface of a surface, with some help, checks.
    
    <pre>subsurface(s,r): return surface</pre>
    """
    r = pygame.Rect(r)
    if r.x < 0 or r.y < 0:
        raise "gui.subsurface: %d %d %s"%(s.get_width(),s.get_height(),r)
    w,h = s.get_width(),s.get_height()
    if r.right > w:
        r.w -= r.right-w
    if r.bottom > h:
        r.h -= r.bottom-h
    assert(r.w >= 0 and r.h >= 0)
    return s.subsurface(r)

class ProxySurface:
    """
    A surface-like object which smartly handle out-of-area blitting.
    
    <pre>ProxySurface(parent, rect, real_surface=None, offset=(0, 0))</pre>
    
    <p>only one of parent and real_surface should be supplied (non None)</p>
    <dl>
    <dt>parent<dd>a ProxySurface object
    <dt>real_surface<dd>a pygame Surface object
    </dl>
  
    <strong>Variables</strong>  
    
    <dl>
    <dt>mysubsurface<dd>a real and valid pygame.Surface object to be used
                       for blitting.
    <dt>x, y<dd>if the proxy surface is lefter or higher than the parent,
                x, y hold the diffs.
    <dt>offset<dd>an optional feature which let you scroll the whole blitted
                  content.
    </dl>
    """
    def __init__(self, parent, rect, real_surface, offset=(0, 0)):
        self.offset = offset
        self.x = self.y = 0
        if rect.x < 0: self.x = rect.x
        if rect.y < 0: self.y = rect.y
        self.real_surface = real_surface
        if real_surface == None:
            self.mysubsurface = parent.mysubsurface.subsurface(
                parent.mysubsurface.get_rect().clip(rect))
        else:
            self.mysubsurface = real_surface.subsurface(
                real_surface.get_rect().clip(rect))
        rect.topleft = (0, 0)
        self.rect = rect
        
    def blit(self, s, pos, rect=None):
        if rect == None: rect = s.get_rect()
        pos = (pos[0] + self.offset[0] + self.x, pos[1] + self.offset[1] + self.y)
        self.mysubsurface.blit(s, pos, rect)
        
    def subsurface(self, rect): 
        r = pygame.Rect(rect).move(self.offset[0] + self.x, 
                                   self.offset[1] + self.y)
        return ProxySurface(self, r, self.real_surface)

    def fill(self, color, rect=None): 
        if rect != None: self.mysubsurface.fill(color, rect)
        else: self.mysubsurface.fill(color)
    def get_rect(self): return self.rect
    def get_width(self): return self.rect[2]
    def get_height(self): return self.rect[3]
    def get_abs_offset(): return self.rect[:2]
    def get_abs_parent(): return self.mysubsurface.get_abs_parent()
    def set_clip(self, rect=None): 
        if rect == None: self.mysubsurface.set_clip()
        else: 
            rect = [rect[0] + self.offset[0] + self.x, rect[1] + self.offset[0] + self.y, rect[2], rect[3]]
            self.mysubsurface.set_clip(rect)






class xProxySurface:
    """
    A surface-like object which smartly handle out-of-area blitting.
    
    <pre>ProxySurface(parent, rect, real_surface=None, offset=(0, 0))</pre>
    
    <p>only one of parent and real_surface should be supplied (non None)</p>
    <dl>
    <dt>parent<dd>a ProxySurface object
    <dt>real_surface<dd>a pygame Surface object
    </dl>
  
    <strong>Variables</strong>  
    
    <dl>
    <dt>mysubsurface<dd>a real and valid pygame.Surface object to be used
                       for blitting.
    <dt>x, y<dd>if the proxy surface is lefter or higher than the parent,
                x, y hold the diffs.
    <dt>offset<dd>an optional feature which let you scroll the whole blitted
                  content.
    </dl>
    """
    def __init__(self, parent, rect, real_surface, offset=(0, 0)):
        self.offset = offset
        self.x = self.y = 0
        if rect[0] < 0: self.x = rect[0]
        if rect[1] < 0: self.y = rect[1]
        self.real_surface = real_surface
        if real_surface == None:
            self.mysubsurface = parent.mysubsurface.subsurface(parent.mysubsurface.get_rect().clip(rect))
        else:
            self.mysubsurface = real_surface.subsurface(real_surface.get_rect().clip(rect))
        rect[0], rect[1] = 0, 0
        self.rect = rect
        
    def blit(self, s, pos, rect=None):
        if rect == None: rect = s.get_rect()
        pos = (pos[0] + self.offset[0] + self.x, pos[1] + self.offset[1] + self.y)
        self.mysubsurface.blit(s, pos, rect)
        
    def subsurface(self, rect): return ProxySurface(self, pygame.Rect(rect).move(self.offset[0] + self.x, self.offset[1] + self.y),self.real_surface)
    def fill(self, color, rect=None): 
        if rect != None: self.mysubsurface.fill(color, rect)
        else: self.mysubsurface.fill(color)
    def get_rect(self): return self.rect
    def get_width(self): return self.rect[2]
    def get_height(self): return self.rect[3]
    def get_abs_offset(): return self.rect[:2]
    def get_abs_parent(): return self.mysubsurface.get_abs_parent()
    def set_clip(self, rect=None): 
        if rect == None: self.mysubsurface.set_clip()
        else: 
            rect = [rect[0] + self.offset[0] + self.x, rect[1] + self.offset[0] + self.y, rect[2], rect[3]]
            self.mysubsurface.set_clip(rect)
