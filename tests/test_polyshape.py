#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from Box2D import *
from math import cos, sin

class cl (b2ContactListener):
    pass

class testPolyshape (unittest.TestCase):
    def setUp(self):
        pass

    def dotest(self, world, v):
        body = world.CreateDynamicBody(position=(0,0),
                        shapes=b2PolygonShape(vertices=v) )
        for v1, v2 in zip(v, body.fixtures[0].shape.vertices):
            if v1 != v2:
                raise Exception('Vertices before and after creation unequal. Before and after zipped=%s'
                        % zip(v, body.fixtures[0].shape.vertices))

    def test_vertices(self):

        body = None
        self.cont_list=cl()
        world = b2World(gravity=(0,-10), doSleep=True, contactListener=self.cont_list)

        try:
            # bad vertices list
            body = world.CreateDynamicBody(
                            position=(0,4),
                            shapes=[b2PolygonShape(vertices=(2,1)),
                                    b2PolygonShape(box=(2,1)) 
                                   ]
                             )
        except ValueError:
            pass # good
        else:
            raise Exception("Should have failed with ValueError / length 1")

        self.dotest(world, [(1,0),(1,1),(-1,1)] )
        self.dotest(world, [b2Vec2(1,0),(1,1),b2Vec2(-1,1)] )
        try:
            self.dotest(world, [(0,1,5),(1,1)] )
        except ValueError as s:
            pass # good
        else:
            raise Exception("Should have failed with ValueError / length 3")

        pi=b2_pi
        n=b2_maxPolygonVertices

        # int so floating point representation inconsistencies 
        # don't make the vertex check fail
        v = [(int(20*cos(x*2*pi/n)), int(20*sin(x*2*pi/n))) for x in range(n)]
        self.dotest(world, v)

        try:
            self.dotest(world, [(0,1)]*(b2_maxPolygonVertices+1) )
        except ValueError as s:
            pass # good
        else:
            raise Exception("Should have failed with ValueError / max+1")

        try:
            shape=b2PolygonShape(vertices=[(1,0),(0,-1),(-1,0)] )
        except ValueError as s:
            pass # good, not convex
        else:
            raise Exception("Should have failed with ValueError / checkpolygon")

        shape=b2PolygonShape(vertices=[(0,0), (0,1), (-1,0)] )
        temp=shape.valid

if __name__ == '__main__':
    unittest.main()

