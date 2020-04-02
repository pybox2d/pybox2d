#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from Box2D import *
from math import cos, sin
import sys

class ContactListener(b2ContactListener):
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
        self.cont_list=ContactListener()
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
        except ValueError:
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
        except ValueError:
            pass # good
        else:
            raise Exception("Should have failed with ValueError / max+1")

        # convex hull is used now, this is no longer valid
        #try:
        #    shape=b2PolygonShape(vertices=[(1,0),(0,-1),(-1,0)] )
        #except ValueError:
        #    pass # good, not convex
        #else:
        #    raise Exception("Should have failed with ValueError / checkpolygon")

        shape=b2PolygonShape(vertices=[(0,0), (0,1), (-1,0)] )
        temp=shape.valid

    def checkAlmostEqual(self, v1, v2, msg, places=3):
        if hasattr(v1, '__len__'):
            for i, (a, b) in enumerate(zip(v1, v2)):
                self.assertAlmostEqual(a, b, places=places,
                        msg="(index %d) %s, a=%f b=%f from %s, %s" % (i, msg, a, b, v1, v2))
        else:
            self.assertAlmostEqual(v1, v2, places=places,
                    msg="%s, a=%f b=%f" % (msg, v1, v2))

    def test_distance(self):
        # Transform A -- a simple translation/offset of (0,-0.2)
        self.transformA = b2Transform()
        self.transformA.SetIdentity()
        self.transformA.position = (0, -0.2)

        # Transform B -- a translation and a rotation
        self.transformB = b2Transform()
        self.positionB = b2Vec2(12.017401,0.13678508)
        self.angleB = -0.0109265
        self.transformB.Set(self.positionB, self.angleB)

        # The two shapes, transformed by the respective transform[A,B]
        self.polygonA = b2PolygonShape(box=(10,0.2))
        self.polygonB = b2PolygonShape(box=(2,0.1))

        # Calculate the distance between the two shapes with the specified transforms
        dist_result=b2Distance(shapeA=self.polygonA,
                               transformA=self.transformA,
                               idxA=0,
                               shapeB=self.polygonB,
                               transformB=self.transformB,
                               idxB=0,
                               useRadii=True)
        self.checkAlmostEqual(dist_result[0], (10, 0.01), 'point A', places=2)
        self.checkAlmostEqual(dist_result[1], (10, 0.05), 'point B', places=1)
        self.checkAlmostEqual(dist_result[2], 0.04, 'distance', places=2)
        assert(dist_result[3] == 2)

        input_ = b2DistanceInput(proxyA=b2DistanceProxy(self.polygonA, 0),
                                 transformA=self.transformA,
                                 proxyB=b2DistanceProxy(self.polygonB, 0),
                                 transformB=self.transformB,
                                 useRadii=True)

        assert(dist_result == b2Distance(input_))


if __name__ == '__main__':
    unittest.main()

