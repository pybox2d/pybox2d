#!/usr/bin/env python
"""
This is a simple example of building and running a simulation
using Box2D. Here we create a large ground box and a small dynamic box.

NOTE:
There is no graphical output for this simple example, only text.
"""
 
from Box2D import *

# Define the gravity vector. Note that this can be defined as a tuple or list just as well.
gravity = b2Vec2(0, -10)
 
# Do we want to let bodies sleep?
doSleep = True
 
# Construct a world object, which will hold and simulate the rigid bodies.
world = b2World(gravity, doSleep)

# Define the ground body.
groundBodyDef = b2BodyDef()
groundBodyDef.position = (0, -10)
 
# Call the body factory which allocates memory for the ground body
# from a pool and creates the ground box shape (also from a pool).
# The body is also added to the world.
groundBody = world.CreateBody(groundBodyDef)
 
# Define the ground box shape.
groundBox = b2PolygonShape()
 
# The extents are the half-widths of the box.
groundBox.SetAsBox(50, 10)
 
# Add the ground shape to the ground body.
groundBody.CreateFixture(groundBox)
 
# Define the dynamic body. We set its position and call the body factory.
bodyDef = b2BodyDef()
bodyDef.type = b2_dynamicBody
bodyDef.position = (0, 4)
body = world.CreateBody(bodyDef)
 
# Define another box shape for our dynamic body.
dynamicBox = b2PolygonShape()
dynamicBox.SetAsBox(1, 1)

# Define the dynamic body fixture. 
fixtureDef = b2FixtureDef()
fixtureDef.shape = dynamicBox

# Set the box density to be non-zero, so it will be dynamic.
fixtureDef.density = 1
 
# Override the default friction.
fixtureDef.friction = 0.3
 
# Add the shape to the body.
body.CreateFixture(fixtureDef)
 
# Prepare for simulation. Typically we use a time step of 1/60 of a
# second (60Hz) and 6 velocity/2 position iterations. This provides a 
# high quality simulation in most game scenarios.
timeStep = 1.0 / 60
vel_iters, pos_iters = 6, 2

# This is our little game loop.
for i in range(60):
    # Instruct the world to perform a single step of simulation. It is
    # generally best to keep the time step and iterations fixed.
    world.Step(timeStep, vel_iters, pos_iters)

    # Clear applied body forces. We didn't apply any forces, but you
    # should know about this function.
    world.ClearForces()
 
    # Now print the position and angle of the body.
    print body.position, body.angle

