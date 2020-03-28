#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
import itertools
import sys

class testJoints (unittest.TestCase):
    world = None
    dbody1 = None
    dbody2 = None
    sbody1 = None
    sbody2 = None

    def _fail(self, s):
        # This little function would save us from an AssertionError on garbage collection.
        # It forces the gc to take care of the world early.
        self.world = None
        self.dbody1 = None
        self.dbody2 = None
        self.sbody1 = None
        self.sbody2 = None
        self.b2 = None
        self.fail(s)

    def setUp(self):
        self.b2 = __import__('Box2D')
        try:
            self.world = self.b2.b2World(self.b2.b2Vec2(0.0, -10.0), True)
        except Exception as ex:
            self.fail("Failed to create world (%s)" % ex)

        try:
            self.dbody1 = self.create_body((-3, 12))
            self.dbody1.userData = "dbody1"
            self.dbody2 = self.create_body((0, 12))
            self.dbody2.userData = "dbody2"
        except Exception as ex:
            self._fail("Failed to create dynamic bodies (%s)" % ex)

        try:
            self.sbody1 = self.create_body((0, 0), False)
            self.sbody1.userData = "sbody1"
            self.sbody2 = self.create_body((1, 4), False)
            self.sbody2.userData = "sbody2"
        except Exception as ex:
            self._fail("Failed to create static bodies (%s)" % ex)

    def create_body(self, position, dynamic=True):
        bodyDef = self.b2.b2BodyDef()
        fixtureDef = self.b2.b2FixtureDef()
        if dynamic:
            bodyDef.type = self.b2.b2_dynamicBody
            fixtureDef.density = 1
        else:
            bodyDef.type = self.b2.b2_staticBody
            fixtureDef.density = 0

        bodyDef.position = position
        body = self.world.CreateBody(bodyDef)

        dynamicBox = self.b2.b2PolygonShape()
        dynamicBox.SetAsBox(1, 1)

        fixtureDef.shape = dynamicBox
        fixtureDef.friction = 0.3

        body.CreateFixture(fixtureDef)
        return body

    def create_circle_body(self, position, dynamic=True):
        bodyDef = self.b2.b2BodyDef()
        fixtureDef = self.b2.b2FixtureDef()
        if dynamic:
            bodyDef.type = self.b2.b2_dynamicBody
            fixtureDef.density = 1
        else:
            bodyDef.type = self.b2.b2_staticBody
            fixtureDef.density = 0

        bodyDef.position = position
        body = self.world.CreateBody(bodyDef)

        body.CreateFixture(shape=self.b2.b2CircleShape(radius=1.0), density=1.0, friction=0.3)
        return body

    def step_world(self, steps=10):
        timeStep = 1.0 / 60
        vel_iters, pos_iters = 6, 2

        for i in range(steps):
            self.world.Step(timeStep, vel_iters, pos_iters)

    def check(self, dfn, joint, prop, joint_prop=""):
        a = getattr(dfn, prop)
        if joint_prop:
            b = getattr(joint, joint_prop)
        else:
            b = getattr(joint, prop)

        self.assertEquals(a, b, "Property not equal from definition to joint: %s (dfn %s != joint %s)" % (prop, a, b) )

    # ---- revolute joint ----
    def revolute_definition(self, body1, body2, anchor):
        dfn=self.b2.b2RevoluteJointDef()
        dfn.Initialize(body1, body2, anchor)
        dfn.motorSpeed = 1.0 * self.b2.b2_pi
        dfn.maxMotorTorque = 10000.0
        dfn.enableMotor = False
        dfn.lowerAngle = -0.25 * self.b2.b2_pi
        dfn.upperAngle = 0.5 * self.b2.b2_pi
        dfn.enableLimit = True
        dfn.collideConnected = True
        return dfn

    def revolute_asserts(self, dfn, joint):
        self.check(dfn, joint, "motorSpeed")
        self.check(dfn, joint, "lowerAngle", "lowerLimit")
        self.check(dfn, joint, "upperAngle", "upperLimit")
        self.check(dfn, joint, "enableMotor", "motorEnabled")
        self.check(dfn, joint, "enableLimit", "limitEnabled")
        self.check(dfn, joint, "bodyA")
        self.check(dfn, joint, "bodyB")

    def revolute_checks(self, dfn, joint):
        # check to make sure they are at least accessible
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)
        joint.GetMotorTorque(1.0)
        i = joint.angle
        i = joint.speed
        i = joint.anchorA
        i = joint.anchorB
        joint.upperLimit = 2
        joint.maxMotorTorque = 10.0
        joint.foobar = 2

    # ---- prismatic joint ----
    def prismatic_definition(self, body1, body2, anchor, axis):
        dfn=self.b2.b2PrismaticJointDef()
        dfn.Initialize(body1, body2, anchor, axis)
        dfn.motorSpeed = 10
        dfn.maxMotorForce = 1000.0
        dfn.enableMotor = True
        dfn.lowerTranslation = 0
        dfn.upperTranslation = 20
        dfn.enableLimit = True
        return dfn

    def prismatic_asserts(self, dfn, joint):
        self.check(dfn, joint, "motorSpeed")
        self.check(dfn, joint, "lowerTranslation", "lowerLimit")
        self.check(dfn, joint, "upperTranslation", "upperLimit")
        self.check(dfn, joint, "enableMotor", "motorEnabled")
        self.check(dfn, joint, "enableLimit", "limitEnabled")
        self.check(dfn, joint, "bodyA")
        self.check(dfn, joint, "bodyB")
        self.check(dfn, joint, "maxMotorForce")

    def prismatic_checks(self, dfn, joint):
        # check to make sure they are at least accessible
        i = joint.GetMotorForce(1.0)
        i = joint.anchorA
        i = joint.anchorB
        i = joint.speed
        i = joint.translation
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    # ---- distance joint ----
    def distance_definition(self, body1, body2, anchorA, anchorB):
        dfn=self.b2.b2DistanceJointDef()
        dfn.Initialize(body1, body2, anchorA, anchorB)
        dfn.length = (self.b2.b2Vec2(*anchorA) - self.b2.b2Vec2(*anchorB)).length
        dfn.frequencyHz = 4.0
        dfn.dampingRatio = 0.5
        return dfn

    def distance_asserts(self, dfn, joint):
        self.check(dfn, joint, "bodyA")
        self.check(dfn, joint, "bodyB")
        self.check(dfn, joint, "length")
        self.check(dfn, joint, "frequencyHz", "frequency")
        self.check(dfn, joint, "dampingRatio")

    def distance_checks(self, dfn, joint):
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    # ---- Rope joint ----
    def rope_definition(self, body1, body2, anchorA, anchorB, maxLength):
        dfn=self.b2.b2RopeJointDef(bodyA=body1, bodyB=body2, anchorA=anchorA, \
                        anchorB=anchorB, maxLength=maxLength)
        return dfn

    def rope_asserts(self, dfn, joint):
        self.check(dfn, joint, "bodyA")
        self.check(dfn, joint, "bodyB")
        self.check(dfn, joint, "maxLength")

    def rope_checks(self, dfn, joint):
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)
        joint.limitState

    # ---- pulley joint ----
    def pulley_definition(self, body1, body2):
        if body2.mass == 0 or body1.mass == 0:
            body1 = self.dbody2
            body2 = self.dbody1

        dfn=self.b2.b2PulleyJointDef()
        a, b = 2, 4
        y, L = 16, 12

        anchor1      =(body1.position.x, y + b)
        anchor2      =(body1.position.x, y + b)
        groundAnchor1=(body1.position.x, y + b + L)
        groundAnchor2=(body1.position.x, y + b + L)
        dfn.Initialize(body1, body2, groundAnchor1, groundAnchor2, anchor1, anchor2, 2.0)
        return dfn

    def pulley_asserts(self, dfn, joint):
        self.check(dfn, joint, "bodyA")
        self.check(dfn, joint, "bodyB")
        self.check(dfn, joint, "groundAnchorA")
        self.check(dfn, joint, "groundAnchorB")
        self.check(dfn, joint, "ratio")

    def pulley_checks(self, dfn, joint):
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    # ---- mouse joint ----
    def mouse_definition(self, body1, body2):
        dfn=self.b2.b2MouseJointDef()
        if body2.mass == 0:
            body2 = self.dbody1
            if body2 == body1:
                body1 = self.sbody1
        dfn.bodyA = body1
        dfn.bodyB = body2
        dfn.target = (2, 1)
        dfn.maxForce = 10
        return dfn

    def mouse_asserts(self, dfn, joint):
        self.check(dfn, joint, "target")
        self.check(dfn, joint, "maxForce")
        self.check(dfn, joint, "frequencyHz", "frequency")
        self.check(dfn, joint, "dampingRatio")

    def mouse_checks(self, dfn, joint):
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    # ---- wheel joint ----
    def wheel_definition(self, body1, body2, anchor, axis):
        dfn=self.b2.b2WheelJointDef()
        dfn.Initialize(body1, body2, anchor, axis)
        dfn.motorSpeed = 0
        dfn.maxMotorForce = 100.0
        dfn.enableMotor = True
        dfn.lowerTranslation = -4.0
        dfn.upperTranslation = 4.0
        dfn.enableLimit = True
        return dfn

    def wheel_asserts(self, dfn, joint):
        self.check(dfn, joint, "motorSpeed")
        self.check(dfn, joint, "maxMotorTorque")
        self.check(dfn, joint, "enableMotor", "motorEnabled")
        self.check(dfn, joint, "bodyA")
        self.check(dfn, joint, "bodyB")
        self.check(dfn, joint, "frequencyHz", "springFrequencyHz")
        self.check(dfn, joint, "dampingRatio", "springDampingRatio")

    def wheel_checks(self, dfn, joint):
        # check to make sure they are at least accessible
        i = joint.anchorA
        i = joint.anchorB
        i = joint.speed
        i = joint.translation
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    # ---- weld joint ----
    def weld_definition(self, body1, body2):
        dfn=self.b2.b2WeldJointDef()
        dfn.bodyA = body1
        dfn.bodyB = body2
        return dfn

    def weld_asserts(self, dfn, joint):
        pass

    def weld_checks(self, dfn, joint):
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    # ---- friction joint ----
    def friction_definition(self, body1, body2):
        dfn=self.b2.b2FrictionJointDef()
        dfn.bodyA = body1
        dfn.bodyB = body2
        dfn.localAnchorA = dfn.localAnchorB = (0,0)
        dfn.collideConnected = True
        dfn.maxForce = 10.0
        dfn.maxTorque = 20.0
        return dfn

    def friction_asserts(self, dfn, joint):
        self.check(dfn, joint, "maxForce")
        self.check(dfn, joint, "maxTorque")

    def friction_checks(self, dfn, joint):
        joint.GetReactionForce(1.0)
        joint.GetReactionTorque(1.0)

    def do_joint(self, name, init_args):
        '''test a joint by name'''
        get_dfn = getattr(self, "%s_definition"%name)
        asserts = getattr(self, "%s_asserts"%name)
        checks  = getattr(self, "%s_checks"%name)
        create_name=getattr(self.world, "Create%sJoint" % (name.capitalize()))

        for bodyA, bodyB in itertools.permutations( ( self.sbody1, self.sbody2, self.dbody1, self.dbody2), 2 ):
            try:
                dfn = get_dfn(body1=bodyA, body2=bodyB, **init_args)
            except Exception as ex:
                self._fail("%s: Failed on bodies %s and %s, joint definition (%s)" % (name, bodyA.userData, bodyB.userData, ex))

            kw_args = {}
            try:
                kw_args = dfn.to_kwargs()
                joint = create_name(**kw_args)
                self.world.DestroyJoint(joint)
            except Exception as ex:
                self._fail("%s: Failed on bodies %s and %s, joint creation by kwargs (%s) kw=%s" % (name, bodyA.userData, bodyB.userData, ex, kw_args))

            try:
                joint = self.world.CreateJoint(dfn)
            except Exception as ex:
                self._fail("%s: Failed on bodies %s and %s, joint creation (%s)" % (name, bodyA.userData, bodyB.userData, ex))

            try:
                asserts(dfn, joint)
            except Exception as ex:
                self.world.DestroyJoint(joint)
                raise

            try:
                checks(dfn, joint)
            except Exception as ex:
                self.world.DestroyJoint(joint)
                self._fail("%s: Failed on bodies %s and %s, joint checks (%s)" % (name, bodyA.userData, bodyB.userData, ex))

            try:
                self.step_world(5)
            except Exception as ex:
                # self.world.DestroyJoint(joint) # -> locked
                try:
                    # Ok, this will cause an assertion to go off during unwinding (in the b2StackAllocator deconstructor),
                    # so do it once, catch that, and then fail finally
                    self.fail()
                except AssertionError as ex:
                    self._fail("%s: Failed on bodies %s and %s, joint simulation (%s)" % (name, bodyA.userData, bodyB.userData, ex))

            try:
                self.world.DestroyJoint(joint)
            except Exception as ex:
                s=sys.exc_info()[1]
                self._fail("%s: Failed on bodies %s and %s joint deletion (%s)" % (name, bodyA.userData, bodyB.userData, s))

    # --- the actual tests ---
    def test_revolute(self):
        self.do_joint("revolute", { 'anchor' : (0, 12) })

    def test_prismatic(self):
        self.do_joint("prismatic", { 'anchor' : (0, 0), 'axis' : (1,0) })

    def test_distance(self):
        self.do_joint("distance", { 'anchorA' : (-10, 0), 'anchorB' : (-0.5,-0.5) })

    def test_rope(self):
        self.do_joint("rope", { 'anchorA' : (-10, 0), 'anchorB' : (-0.5,-0.5), 'maxLength' : 5.0 })

    def test_pulley(self):
        self.do_joint("pulley", {} )

    def test_mouse(self):
        self.do_joint("mouse", {} )

    def test_wheel(self):
        self.do_joint("wheel", { 'anchor' : (0, 8.5), 'axis' : (2,1) })

    def test_weld(self):
        self.do_joint("weld", {} )

    def test_friction(self):
        self.do_joint("friction", {} )

    def test_emptyjoint(self):
        try:
            self.world.CreateJoint( self.b2.b2RevoluteJointDef() )
        except ValueError:
            pass # good
        else:
            raise Exception('Empty joint should have raised an exception')

    def test_gear(self):
        # creates 2 revolute joints and then joins them, so it's done separately
        ground=self.world.CreateBody( self.b2.b2BodyDef() )
        shape=self.b2.b2EdgeShape(vertices=((50.0, 0.0), (-50.0, 0.0)))
        ground.CreateFixturesFromShapes(shapes=shape)

        body1=self.create_circle_body((-3, 12))
        body2=self.create_circle_body(( 0, 12))

        jd1=self.b2.b2RevoluteJointDef()
        jd1.Initialize(ground, body1, body1.position)
        joint1 = self.world.CreateJoint(jd1)

        jd2=self.b2.b2RevoluteJointDef()
        jd2.Initialize(ground, body2, body2.position)
        joint2 = self.world.CreateJoint(jd2)

        gjd=self.b2.b2GearJointDef()
        gjd.bodyA = body1
        gjd.bodyB = body2
        gjd.joint1 = joint1
        gjd.joint2 = joint2
        gjd.ratio  = 2.0

        gj = self.world.CreateJoint(gjd)

        self.step_world(10)

        self.check(gjd, gj, "ratio")
        gj.GetReactionForce(1.0)
        gj.GetReactionTorque(1.0)

        self.world.DestroyJoint(gj)
        self.world.DestroyJoint(joint2)
        self.world.DestroyJoint(joint1)


if __name__ == '__main__':
    unittest.main()
