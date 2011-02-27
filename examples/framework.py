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

"""
The framework's base is FrameworkBase. See its help for more information.
"""

from __future__ import print_function
from Box2D import *
from settings import fwSettings

# Use psyco if available
try:
    import psyco
    psyco.full()
except ImportError:
    pass

class fwDestructionListener(b2DestructionListener):
    """
    The destruction listener callback:
    "SayGoodbye" is called when a joint or shape is deleted.
    """
    test = None
    def __init__(self, **kwargs):
        super(fwDestructionListener, self).__init__(**kwargs)

    def SayGoodbye(self, object):
        if isinstance(object, b2Joint):
            if self.test.mouseJoint==object:
                self.test.mouseJoint=None
            else:
                self.test.JointDestroyed(object)
        elif isinstance(object, b2Fixture):
            self.test.FixtureDestroyed(object)

class fwQueryCallback(b2QueryCallback):
    def __init__(self, p): 
        super(fwQueryCallback, self).__init__()
        self.point = p
        self.fixture = None

    def ReportFixture(self, fixture):
        body = fixture.body
        if body.type == b2_dynamicBody:
            inside=fixture.TestPoint(self.point)
            if inside:
                self.fixture=fixture
                # We found the object, so stop the query
                return False
        # Continue the query
        return True

class Keys(object):
    pass

class FrameworkBase(b2ContactListener):
    """
    The base of the main testbed framework.
    
    If you are planning on using the testbed framework and:
    * Want to implement your own renderer (other than Pygame, etc.):
      You should derive your class from this one to implement your own tests.
      See test_Empty.py or any of the other tests for more information.
    * Do NOT want to implement your own renderer:
      You should derive your class from Framework. The renderer chosen in
      fwSettings (see settings.py) or on the command line will automatically 
      be used for your test.
    """
    name = "None"
    description = None
    TEXTLINE_START=30

    def __reset(self):
        """ Reset all of the variables to their starting values.
        Not to be called except at initialization."""
        # Box2D-related
        self.points             = []
        self.world              = None
        self.bomb               = None
        self.mouseJoint         = None
        self.settings           = fwSettings
        self.bombSpawning       = False
        self.bombSpawnPoint     = None
        self.mouseWorld         = None
        self.using_contacts     = False
        self.stepCount          = 0

        # Box2D-callbacks
        self.destructionListener= None
        self.renderer          = None

    def __init__(self):
        super(FrameworkBase, self).__init__()

        self.__reset()

        # Box2D Initialization
        self.world = b2World(gravity=(0,-10), doSleep=True)

        self.destructionListener = fwDestructionListener(test=self)
        self.world.destructionListener=self.destructionListener
        self.world.contactListener=self

    def __del__(self):
        pass

    def Step(self, settings):
        """
        The main physics step.

        Takes care of physics drawing (callbacks are executed after the world.Step() )
        and drawing additional information.
        """

        self.stepCount+=1
        # Don't do anything if the setting's Hz are <= 0
        if settings.hz > 0.0:
            timeStep = 1.0 / settings.hz
        else:
            timeStep = 0.0
        
        # If paused, display so
        if settings.pause:
            if settings.singleStep:
                settings.singleStep=False
            else:
                timeStep = 0.0

            self.DrawStringCR("****PAUSED****", (200,0,0))

        # Set the flags based on what the settings show
        self.renderer.flags=dict(
                drawShapes=settings.drawShapes,
                drawJoints=settings.drawJoints,
                drawAABBs =settings.drawAABBs,
                drawPairs =settings.drawPairs,
                drawCOMs  =settings.drawCOMs,
                # The following is only applicable when using b2DrawExtended.
                # It indicates that the C code should transform box2d coords to
                # screen coordinates.
                convertVertices=isinstance(self.renderer, b2DrawExtended) 
                )

        # Update the debug draw settings so that the vertices will be properly
        # converted to screen coordinates
        self.renderer.StartDraw()

        # Set the other settings that aren't contained in the flags
        self.world.warmStarting=settings.enableWarmStarting
        self.world.continuousPhysics=settings.enableContinuous
        self.world.subStepping=settings.enableSubStepping

        # Reset the collision points
        self.points = []

        # Tell Box2D to step
        self.world.Step(timeStep, settings.velocityIterations, settings.positionIterations)
        self.world.ClearForces()
        self.world.DrawDebugData()

        # If the bomb is frozen, get rid of it.
        if self.bomb and not self.bomb.awake:
            self.world.DestroyBody(self.bomb)
            self.bomb = None

        if settings.drawFPS:
            self.DrawStringCR("FPS %d" % self.fps)
        
        # Take care of additional drawing (stats, fps, mouse joint, slingshot bomb, contact points)
        if settings.drawStats:
            self.DrawStringCR("bodies=%d contacts=%d joints=%d proxies=%d" %
                (self.world.bodyCount, self.world.contactCount, self.world.jointCount, self.world.proxyCount))

            self.DrawStringCR("hz %d vel/pos iterations %d/%d" %
                (settings.hz, settings.velocityIterations, settings.positionIterations))

        # If there's a mouse joint, draw the connection between the object and the current pointer position.
        if self.mouseJoint:
            p1 = self.mouseJoint.anchorB
            p2 = self.mouseJoint.target

            self.renderer.DrawPoint(p1, settings.pointSize, b2Color(0,1,0), world_coordinates=True)
            self.renderer.DrawPoint(p2, settings.pointSize, b2Color(0,1,0), world_coordinates=True)
            self.renderer.DrawSegment(p1, p2, b2Color(0.8,0.8,0.8), world_coordinates=True)

        # Draw the slingshot bomb
        if self.bombSpawning:
            self.renderer.DrawPoint(self.bombSpawnPoint, settings.pointSize, b2Color(0,0,1.0), world_coordinates=True)
            self.renderer.DrawSegment(self.bombSpawnPoint, self.mouseWorld, b2Color(0.8,0.8,0.8), world_coordinates=True)

        # Draw each of the contact points in different colors.
        if self.settings.drawContactPoints:
            for point in self.points:
                if point['state'] == b2_addState:
                    self.renderer.DrawPoint(point['position'], settings.pointSize, b2Color(0.3, 0.95, 0.3), world_coordinates=True)
                elif point['state'] == b2_persistState:
                    self.renderer.DrawPoint(point['position'], settings.pointSize, b2Color(0.3, 0.3, 0.95), world_coordinates=True)

        if settings.drawContactNormals:
            axisScale = 0.3
            for point in self.points:
                p1 = b2Vec2(point['position'])
                p2 = p1 + axisScale * point['normal']
                self.renderer.DrawSegment(p1, p2, b2Color(0.4, 0.9, 0.4), world_coordinates=True)

        self.renderer.EndDraw()

    def ShiftMouseDown(self, p):
        """
        Indicates that there was a left click at point p (world coordinates) with the
        left shift key being held down.
        """
        self.mouseWorld = p

        if not self.mouseJoint:
            self.SpawnBomb(p)

    def MouseDown(self, p):
        """
        Indicates that there was a left click at point p (world coordinates)
        """

        if self.mouseJoint != None:
            return

        # Create a mouse joint on the selected body (assuming it's dynamic)
        # Make a small box.
        aabb = b2AABB(lowerBound=p-(0.001, 0.001), upperBound=p+(0.001, 0.001))

        # Query the world for overlapping shapes.
        query = fwQueryCallback(p)
        self.world.QueryAABB(query, aabb)
        
        if query.fixture:
            body = query.fixture.body
            # A body was selected, create the mouse joint
            self.mouseJoint = self.world.CreateMouseJoint(
                    bodyA=self.groundbody,
                    bodyB=body, 
                    target=p,
                    maxForce=1000.0*body.mass)
            body.awake = True

    def MouseUp(self, p):
        """
        Left mouse button up.
        """     
        if self.mouseJoint:
            self.world.DestroyJoint(self.mouseJoint)
            self.mouseJoint = None

        if self.bombSpawning:
            self.CompleteBombSpawn(p)

    def MouseMove(self, p):
        """
        Mouse moved to point p, in world coordinates.
        """
        self.mouseWorld = p
        if self.mouseJoint:
            self.mouseJoint.target = p

    def SpawnBomb(self, worldPt):
        """
        Begins the slingshot bomb by recording the initial position.
        Once the user drags the mouse and releases it, then 
        CompleteBombSpawn will be called and the actual bomb will be
        released.
        """
        self.bombSpawnPoint = worldPt.copy()
        self.bombSpawning = True

    def CompleteBombSpawn(self, p):
        """
        Create the slingshot bomb based on the two points
        (from the worldPt passed to SpawnBomb to p passed in here)
        """
        if not self.bombSpawning: 
            return
        multiplier = 30.0
        vel  = self.bombSpawnPoint - p
        vel *= multiplier
        self.LaunchBomb(self.bombSpawnPoint, vel)
        self.bombSpawning = False

    def LaunchBomb(self, position, velocity):
        """
        A bomb is a simple circle which has the specified position and velocity.
        position and velocity must be b2Vec2's.
        """
        if self.bomb:
            self.world.DestroyBody(self.bomb)
            self.bomb = None

        self.bomb = self.world.CreateDynamicBody(
                        allowSleep=True, 
                        position=position, 
                        linearVelocity=velocity,
                        fixtures=b2FixtureDef( 
                            shape=b2CircleShape(radius=0.3), 
                            density=20, 
                            restitution=0.1 )
                            
                    )

    def LaunchRandomBomb(self):
        """
        Create a new bomb and launch it at the testbed.
        """
        p = b2Vec2( b2Random(-15.0, 15.0), 30.0 )
        v = -5.0 * p
        self.LaunchBomb(p, v)
     
    def SimulationLoop(self):
        """
        The main simulation loop. Don't override this, override Step instead.
        """

        # Reset the text line to start the text from the top
        self.textLine = self.TEXTLINE_START

        # Draw the name of the test running
        self.DrawStringCR(self.name, (127,127,255))

        if self.description:
            # Draw the name of the test running
            for s in self.description.split('\n'):
                self.DrawStringCR(s, (127,255,127))

        # Do the main physics step
        self.Step(self.settings)

    def ConvertScreenToWorld(self, x, y):
        """
        Return a b2Vec2 in world coordinates of the passed in screen coordinates x, y
        NOTE: Renderer subclasses must implement this
        """
        raise NotImplementedError()

    def DrawString(self, x, y, str, color=(229,153,153,255)):
        """
        Draw some text, str, at screen coordinates (x, y).
        NOTE: Renderer subclasses must implement this
        """
        raise NotImplementedError()

    def DrawStringCR(self, str, color=(229,153,153,255)):
        """
        Draw some text at the top status lines
        and advance to the next line.
        NOTE: Renderer subclasses must implement this
        """
        raise NotImplementedError()

    def PreSolve(self, contact, old_manifold):
        """
        This is a critical function when there are many contacts in the world.
        It should be optimized as much as possible.
        """
        if not (self.settings.drawContactPoints or self.settings.drawContactNormals or self.using_contacts):
            return
        elif len(self.points) > self.settings.maxContactPoints:
            return

        manifold = contact.manifold
        if manifold.pointCount == 0:
            return

        state1, state2 = b2GetPointStates(old_manifold, manifold)
        if not state2:
            return

        worldManifold = contact.worldManifold
        
        for i, point in enumerate(state2):
            # TODO: find some way to speed all of this up.
            self.points.append(
                    {
                        'fixtureA' : contact.fixtureA,
                        'fixtureB' : contact.fixtureB,
                        'position' : worldManifold.points[i],
                        'normal' : worldManifold.normal,
                        'state' : state2[i]
                    }  )

            continue
            # This is slow, creating a new type with the kwargs and all.
            self.points.append(
                    b2ContactPoint(
                        fixtureA = contact.fixtureA,
                        fixtureB = contact.fixtureB,
                        position = worldManifold.points[i],
                        normal = worldManifold.normal,
                        state = state2[i]
                        ) 
                    )

    # These can/should be implemented in the test subclass: (Step() also if necessary)
    # See test_Empty.py for a simple example.
    def BeginContact(self, contact):
        pass
    def EndContact(self, contact):
        pass
    def PostSolve(self, contact, impulse):
        pass

    def FixtureDestroyed(self, fixture):
        """
        Callback indicating 'fixture' has been destroyed.
        """
        pass

    def JointDestroyed(self, joint):
        """
        Callback indicating 'joint' has been destroyed.
        """
        pass

    def Keyboard(self, key):
        """
        Callback indicating 'key' has been pressed down.
        """
        pass

    def KeyboardUp(self, key):
        """
        Callback indicating 'key' has been released.
        """
        pass

def main(test_class):
    """
    Loads the test class and executes it.
    """
    print("Loading %s..." % test_class.name)
    test = test_class()
    if fwSettings.onlyInit:
        return
    test.run()

if __name__=='__main__':
    print('Please run one of the examples directly. This is just the base for all of the frameworks.')
    exit(0)
# Your framework classes should follow this format. If it is the 'foobar'
# framework, then your file should be 'foobar_framework.py' and you should
# have a class 'FoobarFramework' that derives FrameworkBase. Ensure proper
# capitalization for portability.
try:
    framework_module=__import__('%s_framework' % (fwSettings.backend.lower()), fromlist=['%sFramework' % fwSettings.backend.capitalize()])
    Framework=getattr(framework_module, '%sFramework' % fwSettings.backend.capitalize())
except Exception as ex:
    print('Unable to import the back-end %s: %s' % (fwSettings.backend, ex))
    print('Attempting to fall back on the pygame back-end.')

    from pygame_framework import PygameFramework as Framework
#s/\.Get\(.\)\(.\{-\}\)()/.\L\1\l\2/g
