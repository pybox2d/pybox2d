#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
import Box2D as b2

class testEdgeChain (unittest.TestCase):
    def setUp(self):
        pass

    def test_create_edge_chain(self):
        world = b2.b2World()

        ground = world.CreateBody(position=(0, 20))

        try:
            ground.CreateEdgeChain([])
        except ValueError:
            pass #good
        except Exception as s:
            self.fail("Failed to create empty edge chain (%s)" % s)

        try:
            ground.CreateEdgeChain(
                                [ (-20,-20),
                                  (-20, 20),
                                  ( 20, 20),
                                  ( 20,-20),
                                  (-20,-20) ]
                                )
        except Exception as s:
            self.fail("Failed to create valid edge chain (%s)" % s)

    def test_b2EdgeShape(self):
        world = b2.b2World()

        v1=(-10.0, 0.0)
        v2=(-7.0, -1.0)
        v3=(-4.0, 0.0)

        ground=world.CreateStaticBody(shapes=
                [b2.b2EdgeShape(vertices=[None, v1, v2, v3])])

if __name__ == '__main__':
    unittest.main()

