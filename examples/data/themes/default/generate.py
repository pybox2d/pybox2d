import pygame
from pygame.locals import *
pygame.display.init()
pygame.display.set_mode((80,80),32)

def prep(name):
    fname = name+".png"
    img = pygame.image.load(fname)
    w,h = img.get_width()/2,img.get_height()/2
    
    out = pygame.Surface((w*3,h*3),SWSURFACE|SRCALPHA,32)
    out.fill((0,0,0,0))
    out.blit(img.subsurface(0,0,w,h),(0,0))
    out.blit(img.subsurface(w,0,w,h),(w*2,0))
    out.blit(img.subsurface(0,h,w,h),(0,h*2))
    out.blit(img.subsurface(w,h,w,h),(w*2,h*2))
    for i in range(0,w):
        img = out.subsurface((w-1,0,1,h*3)).convert_alpha()
        out.blit(img,(w+i,0))
    for i in range(0,h):
        img = out.subsurface((0,h-1,w*3,1)).convert_alpha()
        out.blit(img,(0,h+i))
    
    return out,w,h
    
todo = [
    ('button.normal','dot.normal',None,3,3,'789456123'),
    ('button.hover','dot.hover',None,3,3,'789456123'),
    ('button.down','dot.down',None,3,3,'789456123'),
    
    ('checkbox.off.normal','box.normal',None,2,2,'7913'),
    ('checkbox.on.normal','box.down','check',2,2,'7913'),
    ('checkbox.off.hover','box.hover',None,2,2,'7913'),
    ('checkbox.on.hover','box.hover','check',2,2,'7913'),
    
    ('radio.off.normal','dot.normal',None,2,2,'7913'),
    ('radio.on.normal','dot.down','radio',2,2,'7913'),
    ('radio.off.hover','dot.hover',None,2,2,'7913'),
    ('radio.on.hover','dot.hover','radio',2,2,'7913'),
    
    ('tool.normal','box.normal',None,3,3,'789456123'),
    ('tool.hover','box.hover',None,3,3,'789456123'),
    ('tool.down','box.down',None,3,3,'789456123'),
    
    ('hslider','idot.normal',None,3,3,'789456123'),
    ('hslider.bar.normal','dot.normal',None,3,3,'789456123'),
    ('hslider.bar.hover','dot.hover',None,3,3,'789456123'),
    ('hslider.left','sbox.normal','left',2,2,'7913'),
    ('hslider.right','sbox.normal','right',2,2,'7913'),
    
    
    ('vslider','idot.normal',None,3,3,'789456123'),
    ('vslider.bar.normal','vdot.normal',None,3,3,'789456123'),
    ('vslider.bar.hover','vdot.hover',None,3,3,'789456123'),
    ('vslider.up','vsbox.normal','up',2,2,'7913'),
    ('vslider.down','vsbox.normal','down',2,2,'7913'),
    
    ('dialog.close.normal','rdot.hover',None,2,2,'7913'),
    ('dialog.close.hover','rdot.hover','x',2,2,'7913'),
    ('dialog.close.down','rdot.down','x',2,2,'7913'),
    
    ('menu.normal','desktop',None,1,1,'7'),
    ('menu.hover','box.normal',None,3,3,'789456123'),
    ('menu.down','box.down',None,3,3,'789456123'),
    
    ('select.selected.normal','box.normal',None,3,3,'788455122'),
    ('select.selected.hover','box.hover',None,3,3,'788455122'),
    ('select.selected.down','box.down',None,3,3,'788455122'),
    
    ('select.arrow.normal','box.hover',None,3,3,'889556223'),
    ('select.arrow.hover','box.hover',None,3,3,'889556223'),
    ('select.arrow.down','box.down',None,3,3,'889556223'),
    
    ('progressbar','sbox.normal',None,3,3,'789456123'),
    ('progressbar.bar','box.hover',None,3,3,'789456123'),
    ]
    
for fname,img,over,ww,hh,s in todo:
    print(fname)
    img,w,h = prep(img)
    out = pygame.Surface((ww*w,hh*h),SWSURFACE|SRCALPHA,32)
    out.fill((0,0,0,0))
    n = 0
    for y in range(0,hh):
        for x in range(0,ww):
            c = int(s[n])
            xx,yy = (c-1)%3,2-(c-1)/3
            out.blit(img.subsurface((xx*w,yy*h,w,h)),(x*w,y*h))
            n += 1
    if over != None:
        over = pygame.image.load(over+".png")
        out.blit(over,(0,0))
    pygame.image.save(out,fname+".tga")
    
    
    

    
