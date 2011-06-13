from __future__ import print_function

# add "b2ContactPoint", as it's custom

# First, define some classes not seen by swig
ignore = ["b2ContactConstraint", "b2PolygonContact", "b2PolygonAndCircleContact", "b2CircleContact", "b2JointType", "b2BodyType", "b2ContactSolver", "b2PointState", "b2WorldQueryWrapper", "b2WorldRayCastWrapper", "b2SeparationFunction", "b2Block", "b2ContactConstraintPoint", "b2PositionSolverManifold", "b2LimitState"]

# Then check which ones we manually ignore
for line in open('../Box2D/Box2D.i', 'r').readlines():
    if '%ignore' in line:
        c = line.split('ignore ')[1].strip()
        if ';' not in c: 
            continue
        c = c[:c.index(';')].strip()
        ignore.append(c)

all_classes= [
    "b2AABB", 
    "b2Block", 
    "b2BlockAllocator", 
    "b2Body", 
    "b2BodyDef", 
    "b2BodyType", 
    "b2BroadPhase", 
    "b2Chunk", 
    "b2CircleContact", 
    "b2CircleShape", 
    "b2ClipVertex", 
    "b2Color", 
    "b2Contact", 
    "b2ContactPoint", 
    "b2ContactConstraint", 
    "b2ContactConstraintPoint", 
    "b2ContactEdge", 
    "b2ContactFilter", 
    "b2ContactID", 
    "b2ContactImpulse", 
    "b2ContactListener", 
    "b2ContactManager", 
    "b2ContactRegister", 
    "b2ContactSolver", 
    "b2DebugDraw", 
    "b2DestructionListener", 
    "b2DistanceInput", 
    "b2DistanceJoint", 
    "b2DistanceJointDef", 
    "b2DistanceOutput", 
    "b2DistanceProxy", 
    "b2DynamicTree", 
    "b2DynamicTreeNode", 
    "b2Filter", 
    "b2Fixture", 
    "b2FixtureDef", 
    "b2FrictionJoint", 
    "b2FrictionJointDef", 
    "b2GearJoint", 
    "b2GearJointDef", 
    "b2Island", 
    "b2Jacobian", 
    "b2Joint", 
    "b2JointDef", 
    "b2JointEdge", 
    "b2JointType", 
    "b2LimitState", 
    "b2LineJoint", 
    "b2LineJointDef", 
    "b2Manifold", 
    "b2ManifoldPoint", 
    "b2MassData", 
    "b2Mat22", 
    "b2Mat33", 
    "b2MouseJoint", 
    "b2MouseJointDef", 
    "b2Pair", 
    "b2PointState", 
    "b2PolygonAndCircleContact", 
    "b2PolygonContact", 
    "b2PolygonShape", 
    "b2Position", 
    "b2PositionSolverManifold", 
    "b2PrismaticJoint", 
    "b2PrismaticJointDef", 
    "b2PulleyJoint", 
    "b2PulleyJointDef", 
    "b2QueryCallback", 
    "b2RayCastCallback", 
    "b2RayCastInput", 
    "b2RayCastOutput", 
    "b2RevoluteJoint", 
    "b2RevoluteJointDef", 
    "b2Segment", 
    "b2SeparationFunction", 
    "b2Shape", 
    "b2Simplex", 
    "b2SimplexCache", 
    "b2SimplexVertex", 
    "b2StackAllocator", 
    "b2StackEntry", 
    "b2Sweep", 
    "b2TimeStep", 
    "b2TOIInput", 
    "b2Transform", 
    "b2Vec2", 
    "b2Vec3", 
    "b2Velocity", 
    "b2Version", 
    "b2WeldJoint", 
    "b2WeldJointDef", 
    "b2World", 
    "b2WorldManifold", 
    "b2WorldQueryWrapper", 
    "b2WorldRayCastWrapper" ]

# Statistics
print("Total classes: %d" % len(all_classes))
print('Ignored classes:', len(ignore))
for c in ignore:
    if c not in all_classes:
        print('%s not found' % c)
    else:
        all_classes.remove(c)
print('Remaining classes:', len(all_classes))

# And the classes are available in 'all_classes'
