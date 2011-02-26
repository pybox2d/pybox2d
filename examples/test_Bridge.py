#!/usr/bin/python
#
# C++ version Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
# Python version Copyright (c) 2010 Ken Lauer / sirkne at gmail dot com
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

from framework import *

class Bridge (Framework):
    name="Bridge"
    numPlanks = 30 # Number of planks in the bridge
    def __init__(self):
        super(Bridge, self).__init__()

        # The ground
        ground = self.world.CreateBody(
                    shapes=b2EdgeShape(vertices=[(-40,0),(40,0)]) 
                )

        plank=b2FixtureDef( 
                    shape=b2PolygonShape(box=(0.5,0.125)),
                    friction=0.2,
                    density=20
                    )

        prevBody = ground
        for i in range(self.numPlanks):
            body = self.world.CreateDynamicBody(
                        position=(-14.5+i,5), 
                        fixtures=plank,
                    )

            self.world.CreateRevoluteJoint(
                    bodyA=prevBody,
                    bodyB=body,
                    anchor=(-15+i,5)
                )

            prevBody = body

        self.world.CreateRevoluteJoint(
                bodyA=prevBody,
                bodyB=ground,
                anchor=(-15+self.numPlanks,5)
            )

        fixture=b2FixtureDef(
                shape=b2PolygonShape(vertices=
                        [(-0.5,0.0),
                         ( 0.5,0.0),
                         ( 0.0,1.5),
                        ]),
                    density=1.0 
                    ) 
        for i in range(2):
            self.world.CreateDynamicBody(
                    position=(-8+8*i,12), 
                    fixtures=fixture,
                    )

        fixture=b2FixtureDef(shape=b2CircleShape(radius=0.5), density=1)
        for i in range(3):
            self.world.CreateDynamicBody(
                    position=(-6+6*i,10),
                    fixtures=fixture,
                    )

if __name__=="__main__":
     main(Bridge)

