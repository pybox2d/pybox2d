#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from Box2D import *
import Box2D

class cl (b2ContactListener):
    pass

class test_body (unittest.TestCase):
    def setUp(self):
        pass

    def test_world(self):
        world = b2World(gravity=(0,-10), doSleep=True)
        world = b2World((0,-10), True)
        world = b2World((0,-10), doSleep=True)

    def test_extended(self):
        world = b2World()
        fixture1=b2FixtureDef(shape=b2CircleShape(radius=1), density=1, friction=0.3)
        fixture2=b2FixtureDef(shape=b2CircleShape(radius=2), density=1, friction=0.3)
        shape1=b2PolygonShape(box=(5,1))
        shape2=b2PolygonShape(box=(5,1))
        shapefixture=b2FixtureDef(density=2.0, friction=0.3)

        world.CreateStaticBody(fixtures=[fixture1, fixture2],
                shapes=[shape1, shape2], shapeFixture=shapefixture)

        # make sure that 4 bodies were created
        self.assertEqual(len(world.bodies[-1].fixtures), 4)

        world.CreateKinematicBody(fixtures=[fixture1, fixture2],
                shapes=[shape1, shape2], shapeFixture=shapefixture)
        self.assertEqual(len(world.bodies[-1].fixtures), 4)
        world.CreateDynamicBody(fixtures=[fixture1, fixture2],
                shapes=[shape1, shape2], shapeFixture=shapefixture)
        self.assertEqual(len(world.bodies[-1].fixtures), 4)

    def test_body(self):
        self.cont_list=cl()
        world = b2World(gravity=(0,-10), doSleep=True, contactListener=self.cont_list)
        groundBody = world.CreateBody(b2BodyDef(position=(0,-10)))

        groundBody.CreateFixturesFromShapes(shapes=b2PolygonShape(box=(50,10)))

        body = world.CreateBody(b2BodyDef(type=b2_dynamicBody, position=(0,4)))

        body.CreateFixture(b2FixtureDef(shape=b2CircleShape(radius=1), density=1, friction=0.3))

        timeStep = 1.0 / 60
        vel_iters, pos_iters = 6, 2

        for i in range(60):
            world.Step(timeStep, vel_iters, pos_iters)
            world.ClearForces()

    def test_new_createfixture(self):
        world = b2World(gravity=(0,-10), doSleep=True)
        body=world.CreateDynamicBody(position=(0,0))
        body.CreateCircleFixture(radius=0.2, friction=0.2, density=1.0)
        body.fixtures[0]
        body.fixtures[0].friction
        body.fixtures[0].density
        body.fixtures[0].shape.radius

        body.CreatePolygonFixture(box=(1,1), friction=0.2, density=1.0)
        body.fixtures[1]
        body.fixtures[1].friction
        body.fixtures[1].density
        body.fixtures[1].shape.vertices

        v1=(-10, 0)
        v2=(-7, -1)
        v3=(-4, 0)
        v4=(0, 0)
        body.CreateEdgeFixture(vertices=[v1,v2,v3,v4], friction=0.3, density=1.0)
        body.fixtures[2]
        body.fixtures[2].friction
        body.fixtures[2].density
        body.fixtures[2].shape.vertices

        #TODO Loop shapes

    def test_fixture_without_shape(self):
        world = b2World(gravity=(0,-10), doSleep=True)
        body = world.CreateDynamicBody(position=(0,0))

        self.assertRaises(ValueError, body.CreateFixture)


if __name__ == '__main__':
    unittest.main()

