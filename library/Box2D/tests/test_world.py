#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
import Box2D
import sys

class testWorld (unittest.TestCase):
    def setUp(self):
        pass

    def test_world(self):
        try:
            world = Box2D.b2World(Box2D.b2Vec2(0.0, -10.0), True)
            world = Box2D.b2World((0.0, -10.0), True)
            world = Box2D.b2World([0.0, -10.0], False)
            world = Box2D.b2World([0.0, -10.0])
            world = Box2D.b2World()
            world = Box2D.b2World(gravity=[0.0, -10.0])
        except Exception:
            self.fail("Failed to create world (%s)" % sys.exc_info()[1])

    def test_helloworld(self):
        gravity = Box2D.b2Vec2(0, -10)
         
        doSleep = True
         
        world = Box2D.b2World(gravity, doSleep)

        groundBodyDef = Box2D.b2BodyDef()
        groundBodyDef.position = [0, -10]
         
        groundBody = world.CreateBody(groundBodyDef)
         
        groundBox = Box2D.b2PolygonShape()
         
        groundBox.SetAsBox(50, 10)
         
        groundBody.CreateFixturesFromShapes(groundBox)
         
        bodyDef = Box2D.b2BodyDef()
        bodyDef.type = Box2D.b2_dynamicBody
        bodyDef.position = (0, 4)
        body = world.CreateBody(bodyDef)
         
        dynamicBox = Box2D.b2PolygonShape()
        dynamicBox.SetAsBox(1, 1)

        fixtureDef = Box2D.b2FixtureDef()
        fixtureDef.shape = dynamicBox

        fixtureDef.density = 1
         
        fixtureDef.friction = 0.3
         
        body.CreateFixture(fixtureDef)
         
        timeStep = 1.0 / 60
        vel_iters, pos_iters = 6, 2

        for i in range(60):
            world.Step(timeStep, vel_iters, pos_iters)
            world.ClearForces()

if __name__ == '__main__':
    unittest.main()

