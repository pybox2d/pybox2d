# pybox2d -- http://pybox2d.googlecode.com
#
# Copyright (c) 2010 Ken Lauer / sirkne at gmail dot com
# 
# This software is provided 'as-is', without any express or implied
# warranty.  In no event will the authors be held liable for any damages
# arising from the use of this software.
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
# 1. The origin of this software must not be misrepresented; you must not
# claim that you wrote the original software. If you use this software
# in a product, an acknowledgment in the product documentation would be
# appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
# misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

__author__='Ken Lauer'
__license__='zlib'
__date__="$Date$"
__version__="$Revision$"
__doc__="""
This module holds the full usable contents of pybox2d. 
It offers an alternative syntax in the form of:

    from Box2D.b2 import *
    a = vec2(1,1) + vec2(2,2)

This is fully equivalent to:

    from Box2D import *
    a = b2Vec2(1,1) + b2Vec2(2,2)

All classes that exist in the main module that are prefixed 
by b2 or b2_ have been stripped. Beware that importing *
from a module is generally frowned upon -- this is mainly
here for convenience in debugging sessions where typing 
b2Vec2 repeatedly gets very old very quickly (trust me,
I know.)
"""

# Populated by the parent package (see the end of ../Box2D.py)
pass
