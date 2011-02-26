"""Constants.
<br><br>
<strong>Event Types</strong>

<p>from pygame</p>
<dl>
<dt>QUIT
<dt>MOUSEBUTTONDOWN
<dt>MOUSEBUTTONUP
<dt>MOUSEMOTION
<dt>KEYDOWN
</dl>

<p>gui specific</p>
<dl>
<dt>ENTER
<dt>EXIT
<dt>BLUR
<dt>FOCUS
<dt>CLICK
<dt>CHANGE
<dt>OPEN
<dt>CLOSE
<dt>INIT
</dl>

<strong>Other</strong>
<dl>
<dt>NOATTR
</dl>
"""
import pygame

from pygame.locals import QUIT, MOUSEBUTTONDOWN, MOUSEBUTTONUP, MOUSEMOTION, KEYDOWN, USEREVENT
ENTER = pygame.locals.USEREVENT + 0
EXIT = pygame.locals.USEREVENT + 1
BLUR = pygame.locals.USEREVENT + 2
FOCUS = pygame.locals.USEREVENT + 3
CLICK = pygame.locals.USEREVENT + 4
CHANGE = pygame.locals.USEREVENT + 5
OPEN = pygame.locals.USEREVENT + 6
CLOSE = pygame.locals.USEREVENT + 7
INIT = 'init'

class NOATTR: pass