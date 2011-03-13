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
from random import random
from math import sqrt, sin, cos

class RayCastCallback(b2RayCastCallback):
    def __init__(self, **kwargs):
        super(RayCastCallback, self).__init__()
        self.fixture = None

    # Called for each fixture found in the query. You control how the ray proceeds
    # by returning a float that indicates the fractional length of the ray. By returning
    # 0, you set the ray length to zero. By returning the current fraction, you proceed
    # to find the closest point. By returning 1, you continue with the original ray
    # clipping.
    def ReportFixture(self, fixture, point, normal, fraction):
        self.fixture = fixture
        self.point  = b2Vec2(point)
        self.normal = b2Vec2(normal)
        # You will get this error: "TypeError: Swig director type mismatch in output value of type 'float32'"
        # without returning a value
        return fraction

class Raycast (Framework):
    name="Raycast"
    description="Press 1-5 to drop stuff, and d to delete"
    p1_color=b2Color(0.4, 0.9, 0.4)
    s1_color=b2Color(0.8, 0.8, 0.8)
    s2_color=b2Color(0.9, 0.9, 0.4)
    callback=RayCastCallback()
    def __init__(self):
        super(Raycast, self).__init__()

        self.world.gravity = (0,0)
        # The ground
        ground = self.world.CreateBody(
                    shapes=b2EdgeShape(vertices=[(-40,  0),( 40,  0)])
                )

        # The various shapes
        w = 1.0
        b = w / (2.0 + sqrt(2.0))
        s = sqrt(2.0) * b

        self.shapes = [
                    b2PolygonShape(vertices=[(-0.5,0), (0.5,0), (0,1.5)]),
                    b2PolygonShape(vertices=[(-0.1,0), (0.1,0), (0,1.5)]),
                    b2PolygonShape(
                        vertices=[ 
                            (0.5*s, 0.0), (0.5*w, b), (0.5*w, b + s),
                            (0.5*s, w), (-0.5*s, w), (-0.5*w, b + s),
                            (-0.5*w, b), (-0.5*s, 0.0), 
                            ]
                        ),
                    b2PolygonShape(box=(0.5, 0.5)),
                    b2CircleShape(radius=0.5),
                ]
        self.angle = 0
    
    def CreateShape(self, shapeindex):
        try:
            shape = self.shapes[shapeindex]
        except IndexError:
            return

        pos=(10.0*(2.0*random()-1.0), 10.0*(2.0*random()+1.0)) 
        defn = b2BodyDef(
                    type=b2_dynamicBody,
                    fixtures=b2FixtureDef(shape=shape, friction=0.3),
                    position=pos, 
                    angle=(b2_pi * (2.0*random() - 1.0)),
                    )

        if isinstance(shape, b2CircleShape):
            defn.angularDamping=0.02

        self.world.CreateBody(defn)

    def DestroyBody(self):
        for body in self.world.bodies:
            if not self.world.locked:
                self.world.DestroyBody(body)
            break

    def Keyboard(self, key):
         if key in (Keys.K_1, Keys.K_2, Keys.K_3, Keys.K_4, Keys.K_5):
            self.CreateShape(key - Keys.K_1)
         elif key == Keys.K_d:
             self.DestroyBody()

    def Step(self, settings):
        super(Raycast, self).Step(settings)

        # Set up the raycast line
        length=11
        point1=b2Vec2(0, 10)
        d     =(length * cos(self.angle), length * sin(self.angle))
        point2= point1 + d

        callback=self.callback
        callback.fixture=None

        self.world.RayCast(callback, point1, point2)

        # The callback has been called by this point, and if a fixture was hit it will have been
        # set to callback.fixture.
        point1=self.renderer.to_screen(point1)
        point2=self.renderer.to_screen(point2)
        if callback.fixture:
            cb_point=self.renderer.to_screen(callback.point)
            self.renderer.DrawPoint(cb_point, 5.0, self.p1_color)
            self.renderer.DrawSegment(point1, cb_point, self.s1_color)

            head = b2Vec2(cb_point) + 0.5 * callback.normal
            self.renderer.DrawSegment(cb_point, head, self.s2_color)
        else:
            self.renderer.DrawSegment(point1, point2, self.s1_color)

        if not settings.pause or settings.singleStep:
            self.angle += 0.25*b2_pi/180
        
if __name__=="__main__":
     main(Raycast)
