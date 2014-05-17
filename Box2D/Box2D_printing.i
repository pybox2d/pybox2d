//!/usr/bin/python
//
// C++ version copyright 2010 Erin Catto http://www.gphysics.com
// Python version copyright 2010 Ken Lauer / sirkne at gmail dot com
// 
// This software is provided 'as-is', without any express or implied
// warranty.  In no event will the authors be held liable for any damages
// arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not
// claim that you wrote the original software. If you use this software
// in a product, an acknowledgment in the product documentation would be
// appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be
// misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.
// 

%pythoncode %{
_repr_attrs = {'b2AABB': ['center', 'extents', 'lowerBound', 'perimeter', 'upperBound', 
                          'valid', ],
               'b2Body': ['active', 'angle', 'angularDamping', 'angularVelocity', 'awake', 
                          'bullet', 'contacts', 'fixedRotation', 'fixtures', 
                          'inertia', 'joints', 'linearDamping', 'linearVelocity', 
                          'localCenter', 'mass', 'massData', 'position', 
                          'sleepingAllowed', 'transform', 'type', 'userData', 
                          'worldCenter', ],
               'b2BodyDef': ['active', 'allowSleep', 'angle', 'angularDamping', 'angularVelocity', 
                             'awake', 'bullet', 'fixedRotation', 'fixtures', 
                             'inertiaScale', 'linearDamping', 'linearVelocity', 'position', 
                             'shapeFixture', 'shapes', 'type', 'userData', 
                             ],
               'b2BroadPhase': ['proxyCount', ],
               'b2CircleShape': ['childCount', 'pos', 'radius', 'type', ],
               'b2ClipVertex': ['id', 'v', ],
               'b2Color': ['b', 'bytes', 'g', 'list', 'r', 
                           ],
               'b2Contact': ['childIndexA', 'childIndexB', 'enabled', 'fixtureA', 'fixtureB', 
                             'manifold', 'touching', 'worldManifold', ],
               'b2ContactEdge': ['contact', 'other', ],
               'b2ContactFeature': ['indexA', 'indexB', 'typeA', 'typeB', ],
               'b2ContactID': ['cf', 'key', ],
               'b2ContactImpulse': ['normalImpulses', 'tangentImpulses', ],
               'b2ContactManager': ['allocator', 'broadPhase', 'contactCount', 'contactFilter', 'contactList', 
                                    'contactListener', ],
               'b2ContactPoint': ['fixtureA', 'fixtureB', 'normal', 'position', 'state', 
                                  ],
               'b2DistanceInput': ['proxyA', 'proxyB', 'transformA', 'transformB', 'useRadii', 
                                   ],
               'b2DistanceJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                                   'dampingRatio', 'frequency', 'length', 'type', 
                                   'userData', ],
               'b2DistanceJointDef': ['anchorA', 'anchorB', 'bodyA', 'bodyB', 'collideConnected', 
                                      'dampingRatio', 'frequencyHz', 'length', 'localAnchorA', 
                                      'localAnchorB', 'type', 'userData', ],
               'b2DistanceOutput': ['distance', 'iterations', 'pointA', 'pointB', ],
               'b2DistanceProxy': ['m_buffer', 'shape', 'vertices', ],
               'b2Draw': ['flags', ],
               'b2DrawExtended': ['center', 'convertVertices', 'flags', 'flipX', 'flipY', 
                                  'offset', 'screenSize', 'zoom', ],
               'b2EdgeShape': ['all_vertices', 'childCount', 'hasVertex0', 'hasVertex3', 'radius', 
                               'type', 'vertex0', 'vertex1', 'vertex2', 
                               'vertex3', 'vertexCount', 'vertices', ],
               'b2Filter': ['categoryBits', 'groupIndex', 'maskBits', ],
               'b2Fixture': ['body', 'density', 'filterData', 'friction', 'massData', 
                             'restitution', 'sensor', 'shape', 'type', 
                             'userData', ],
               'b2FixtureDef': ['categoryBits', 'density', 'filter', 'friction', 'groupIndex', 
                                'isSensor', 'maskBits', 'restitution', 'shape', 
                                'userData', ],
               'b2FixtureProxy': ['aabb', 'childIndex', 'fixture', 'proxyId', ],
               'b2FrictionJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                                   'maxForce', 'maxTorque', 'type', 'userData', 
                                   ],
               'b2FrictionJointDef': ['anchor', 'bodyA', 'bodyB', 'collideConnected', 'localAnchorA', 
                                      'localAnchorB', 'maxForce', 'maxTorque', 'type', 
                                      'userData', ],
               'b2GearJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                               'ratio', 'type', 'userData', ],
               'b2GearJointDef': ['bodyA', 'bodyB', 'collideConnected', 'joint1', 'joint2', 
                                  'ratio', 'type', 'userData', ],
               'b2Jacobian': ['angularA', 'angularB', 'linearA', 'linearB', ],
               'b2Joint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                           'type', 'userData', ],
               'b2JointDef': ['bodyA', 'bodyB', 'collideConnected', 'type', 'userData', 
                              ],
               'b2JointEdge': ['joint', 'other', ],
               'b2WheelJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                                'maxMotorTorque', 'motorEnabled', 'motorSpeed', 'speed', 
                                'springDampingRatio', 'springFrequencyHz', 'translation', 'type', 
                                'userData', ],
               'b2WheelJointDef': ['anchor', 'axis', 'bodyA', 'bodyB', 'collideConnected', 
                                   'dampingRatio', 'enableMotor', 'frequencyHz', 'localAnchorA', 
                                   'localAnchorB', 'localAxisA', 'maxMotorTorque', 'motorSpeed', 
                                   'type', 'userData', ],
               'b2LoopShape': ['childCount', 'edges', 'radius', 'type', 'vertexCount', 
                               'vertices', ],
               'b2Manifold': ['localNormal', 'localPoint', 'pointCount', 'points', 'type_', 
                              ],
               'b2ManifoldPoint': ['id', 'isNew', 'localPoint', 'normalImpulse', 'tangentImpulse', 
                                   ],
               'b2MassData': ['I', 'center', 'mass', ],
               'b2Mat22': ['angle', 'col1', 'col2', 'inverse', ],
               'b2Mat33': ['col1', 'col2', 'col3', ],
               'b2MouseJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                                'dampingRatio', 'frequency', 'maxForce', 'target', 
                                'type', 'userData', ],
               'b2MouseJointDef': ['bodyA', 'bodyB', 'collideConnected', 'dampingRatio', 'frequencyHz', 
                                   'maxForce', 'target', 'type', 'userData', 
                                   ],
               'b2Pair': ['proxyIdA', 'proxyIdB', ],
               'b2PolygonShape': ['box', 'centroid', 'childCount', 'normals', 'radius', 
                                  'type', 'valid', 'vertexCount', 'vertices', 
                                  ],
               'b2PrismaticJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                                    'limitEnabled', 'limits', 'lowerLimit', 'maxMotorForce', 
                                    'motorEnabled', 'motorSpeed', 'speed', 'translation', 
                                    'type', 'upperLimit', 'userData', ],
               'b2PrismaticJointDef': ['anchor', 'axis', 'bodyA', 'bodyB', 'collideConnected', 
                                       'enableLimit', 'enableMotor', 'localAnchorA', 'localAnchorB', 
                                       'localAxis1', 'lowerTranslation', 'maxMotorForce', 'motorSpeed', 
                                       'referenceAngle', 'type', 'upperTranslation', 'userData', 
                                       ],
               'b2PulleyJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                                 'groundAnchorA', 'groundAnchorB', 'length1', 'length2', 
                                 'ratio', 'type', 'userData', ],
               'b2PulleyJointDef': ['anchorA', 'anchorB', 'bodyA', 'bodyB', 'collideConnected', 
                                    'groundAnchorA', 'groundAnchorB', 'lengthA', 'lengthB', 
                                    'localAnchorA', 'localAnchorB', 'maxLengthA', 'maxLengthB', 
                                    'ratio', 'type', 'userData', ],
               'b2RayCastInput': ['maxFraction', 'p1', 'p2', ],
               'b2RayCastOutput': ['fraction', 'normal', ],
               'b2RevoluteJoint': ['active', 'anchorA', 'anchorB', 'angle', 'bodyA', 
                                   'bodyB', 'limitEnabled', 'limits', 'lowerLimit', 
                                   'maxMotorTorque', 'motorEnabled', 'motorSpeed', 'speed', 
                                   'type', 'upperLimit', 'userData', ],
               'b2RevoluteJointDef': ['anchor', 'bodyA', 'bodyB', 'collideConnected', 'enableLimit', 
                                      'enableMotor', 'localAnchorA', 'localAnchorB', 'lowerAngle', 
                                      'maxMotorTorque', 'motorSpeed', 'referenceAngle', 'type', 
                                      'upperAngle', 'userData', ],
               'b2RopeJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                               'limitState', 'maxLength', 'type', 'userData', 
                               ],
               'b2RopeJointDef': ['anchorA', 'anchorB', 'bodyA', 'bodyB', 'collideConnected', 
                                  'localAnchorA', 'localAnchorB', 'maxLength', 'type', 
                                  'userData', ],
               'b2Shape': ['childCount', 'radius', 'type', ],
               'b2Sweep': ['a', 'a0', 'alpha0', 'c', 'c0', 
                           'localCenter', ],
               'b2TOIInput': ['proxyA', 'proxyB', 'sweepA', 'sweepB', 'tMax', 
                              ],
               'b2TOIOutput': ['state', 't', ],
               'b2Transform': ['R', 'angle', 'position', ],
               'b2Vec2': ['length', 'lengthSquared', 'skew', 'tuple', 'valid', 
                          'x', 'y', ],
               'b2Vec3': ['length', 'lengthSquared', 'tuple', 'valid', 'x', 
                          'y', 'z', ],
               'b2Version': ['major', 'minor', 'revision', ],
               'b2WeldJoint': ['active', 'anchorA', 'anchorB', 'bodyA', 'bodyB', 
                               'type', 'userData', ],
               'b2WeldJointDef': ['anchor', 'bodyA', 'bodyB', 'collideConnected', 'localAnchorA', 
                                  'localAnchorB', 'referenceAngle', 'type', 'userData', 
                                  ],
               'b2World': ['autoClearForces', 'bodies', 'bodyCount', 'contactCount', 'contactFilter', 
                           'contactListener', 'contactManager', 'contacts', 'continuousPhysics', 
                           'destructionListener', 'gravity', 'jointCount', 'joints', 
                           'locked', 'proxyCount', 'renderer', 'subStepping', 
                           'warmStarting', ],
               'b2WorldManifold': ['normal', 'points', ],
               }

MAX_REPR_DEPTH = 4
MAX_REPR_STR_LEN = 250
MAX_REPR_SUB_LINES = 10
REPR_INDENT = 4

_repr_state = {}
def _format_repr(obj):
    """
    Dynamically creates the object representation string for `obj`.
    
    Attributes found in _repr_attrs[class_name] will be included.
    """

    global _repr_state
    if 'spaces' not in _repr_state:
        _repr_state['spaces'] = 0

    if 'depth' not in _repr_state:
        _repr_state['depth'] = 1
    else:
        _repr_state['depth'] += 1

    if _repr_state['depth'] > MAX_REPR_DEPTH:
        _repr_state['depth'] -= 1
        return '%s(max recursion depth hit)' % (' ' * _repr_state['spaces'])
    
    class_line = '%s(' % (obj.__class__.__name__, )
    
    orig_spaces = _repr_state['spaces']

    ret = []

    props = _repr_attrs.get(obj.__class__.__name__, [])

    try:
        prop_spacing = _repr_state['spaces'] + len(class_line.lstrip())
        separator = '\n' + ' ' * prop_spacing
    
        for prop in props:
            _repr_state['spaces'] = len(prop) + 1
            try:
                s = repr(getattr(obj, prop))
            except Exception as ex:
                s = '(repr: %s)' % ex

            lines = s.split('\n')
            if len(lines) > MAX_REPR_SUB_LINES:
                length_ = 0
                for i, line_ in enumerate(lines[:MAX_REPR_SUB_LINES]):
                    length_ += len(line_)
                    if length_ > MAX_REPR_STR_LEN:
                        ending_delim = []
                        for j in s[::-1]:
                            if j in ')]}':
                                ending_delim.insert(0, j)
                            else:
                                break

                        ret[-1] = '%s...  %s' % (ret[-1], ''.join(ending_delim))
                        break

                    if i == 0:
                        ret.append('%s=%s' % (prop, line_))
                    else:
                        ret.append(line_) 
            else:
                ret.append('%s=%s' % (prop, lines[0].lstrip()))
                if len(lines) > 1:
                    ret.extend(lines[1:])

            ret[-1] += ','
        
    finally:
        _repr_state['depth'] -= 1
        _repr_state['spaces'] = orig_spaces
    
    if len(ret) <= 3:
        # Closing parenthesis on same line
        ret[-1] += ')'
        return ''.join(ret)

    else:
        # Closing parenthesis on next line
        ret.append(')')
        return '%s%s' % (class_line, separator.join(ret))
%}

%define REPREXTEND(classname)
%extend classname {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self) 
    %}
}

%enddef

REPREXTEND(b2AABB);
REPREXTEND(b2AssertException);
REPREXTEND(b2Body);
REPREXTEND(b2BodyDef);
REPREXTEND(b2BroadPhase);
REPREXTEND(b2CircleShape);
REPREXTEND(b2ClipVertex);
REPREXTEND(b2Color);
REPREXTEND(b2Contact);
REPREXTEND(b2ContactEdge);
REPREXTEND(b2ContactFeature);
REPREXTEND(b2ContactFilter);
REPREXTEND(b2ContactID);
REPREXTEND(b2ContactImpulse);
REPREXTEND(b2ContactListener);
REPREXTEND(b2ContactManager);
REPREXTEND(b2ContactPoint);
REPREXTEND(b2DestructionListener);
REPREXTEND(b2DistanceInput);
REPREXTEND(b2DistanceJoint);
REPREXTEND(b2DistanceJointDef);
REPREXTEND(b2DistanceOutput);
REPREXTEND(b2DistanceProxy);
REPREXTEND(b2Draw);
REPREXTEND(b2DrawExtended);
REPREXTEND(b2EdgeShape);
REPREXTEND(b2Filter);
REPREXTEND(b2Fixture);
REPREXTEND(b2FixtureDef);
REPREXTEND(b2FixtureProxy);
REPREXTEND(b2FrictionJoint);
REPREXTEND(b2FrictionJointDef);
REPREXTEND(b2GearJoint);
REPREXTEND(b2GearJointDef);
REPREXTEND(b2Jacobian);
REPREXTEND(b2Joint);
REPREXTEND(b2JointDef);
REPREXTEND(b2JointEdge);
REPREXTEND(b2WheelJoint);
REPREXTEND(b2WheelJointDef);
REPREXTEND(b2LoopShape);
REPREXTEND(b2Manifold);
REPREXTEND(b2ManifoldPoint);
REPREXTEND(b2MassData);
REPREXTEND(b2Mat22);
REPREXTEND(b2Mat33);
REPREXTEND(b2MouseJoint);
REPREXTEND(b2MouseJointDef);
REPREXTEND(b2Pair);
REPREXTEND(b2PolygonShape);
REPREXTEND(b2PrismaticJoint);
REPREXTEND(b2PrismaticJointDef);
REPREXTEND(b2PulleyJoint);
REPREXTEND(b2PulleyJointDef);
REPREXTEND(b2QueryCallback);
REPREXTEND(b2RayCastCallback);
REPREXTEND(b2RayCastInput);
REPREXTEND(b2RayCastOutput);
REPREXTEND(b2RevoluteJoint);
REPREXTEND(b2RevoluteJointDef);
REPREXTEND(b2RopeJoint);
REPREXTEND(b2RopeJointDef);
REPREXTEND(b2Shape);
REPREXTEND(b2Sweep);
REPREXTEND(b2TOIInput);
REPREXTEND(b2TOIOutput);
REPREXTEND(b2Transform);
REPREXTEND(b2Vec2);
REPREXTEND(b2Vec3);
REPREXTEND(b2Version);
REPREXTEND(b2WeldJoint);
REPREXTEND(b2WeldJointDef);
REPREXTEND(b2World);
REPREXTEND(b2WorldManifold);
