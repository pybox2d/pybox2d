#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from Box2D import *

class cl (b2ContactListener):
    pass

class test_kwargs (unittest.TestCase):
    def setUp(self):
        pass

    def test_kwargs(self):
        self.cont_list=cl()
        world = b2World(gravity=(0,-10), doSleep=True, contactListener=self.cont_list)
        groundBody = world.CreateBody(b2BodyDef(position=(0,-10)))

        groundBody.CreateFixturesFromShapes(b2PolygonShape(box=(50,10)))

        body = world.CreateBody(b2BodyDef(type=b2_dynamicBody, position=(0,4),
                        fixtures=[]))

        body = world.CreateBody(
                type=b2_dynamicBody,
                position=(0,4),
                fixtures=b2FixtureDef(shape=b2PolygonShape(box=(2,1)), density=1.0)
                )

        body = world.CreateBody(
                    type=b2_dynamicBody,
                    position=(0,4),
                    shapes=(b2PolygonShape(box=(2,1)), b2PolygonShape(box=(2,1))),
                    shapeFixture=b2FixtureDef(density=1.0),
                )

        body = world.CreateBody(
                    type=b2_dynamicBody,
                    position=(0,4),
                    fixtures=b2FixtureDef(shape=b2CircleShape(radius=1), density=1, friction=0.3),
                    shapes=(b2PolygonShape(box=(2,1)), b2PolygonShape(box=(2,1))),
                    shapeFixture=b2FixtureDef(density=1.0),
                )

        body.CreateFixture(shape=b2CircleShape(radius=1), density=1, friction=0.3)
        timeStep = 1.0 / 60
        vel_iters, pos_iters = 6, 2

        for i in range(60):
            world.Step(timeStep, vel_iters, pos_iters)
            world.ClearForces()

    def test_body(self):
        world = b2World(gravity=(0,-10), doSleep=True)
        body = world.CreateBody(b2BodyDef())
        body2 = world.CreateBody(position=(1,1))

    def test_joints(self):
        world = b2World(gravity=(0,-10), doSleep=True)
        body = world.CreateBody(b2BodyDef())
        body2 = world.CreateBody(position=(1,1))
        world.CreateJoint(type=b2RevoluteJoint, bodyA=body, bodyB=body2)
        world.CreateJoint(type=b2RevoluteJointDef, bodyA=body, bodyB=body2)

        kwargs=dict(type=b2RevoluteJointDef, bodyA=body, bodyB=body2)
        world.CreateJoint(**kwargs)

if __name__ == '__main__':
    unittest.main()

