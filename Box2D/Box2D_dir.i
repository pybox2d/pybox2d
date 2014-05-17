/*
* pybox2d -- http://pybox2d.googlecode.com
*
* Copyright (c) 2010 Ken Lauer / sirkne at gmail dot com
* 
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

%pythoncode %{
    def _dir_filter(self):
        """
        Using introspection, mimic dir() by adding up all of the __dicts__
        for the current class and all base classes (type(self).__mro__ returns
        all of the classes that make it up)
        Basically filters by:
            __x__ OK
            __x bad
            _classname bad
        """

        def check(s):
            if s.startswith('__'):
                if s.endswith('__'):
                    return True
                else:
                    return False
            else:
                for typename in typenames:
                    if typename in s:
                        return False
                return True
        
        keys = sum([list(c.__dict__.keys()) for c in type(self).__mro__], [])
        typenames = ["_%s" % c.__name__ for c in type(self).__mro__]
        ret = [s for s in list(set(keys)) if check(s)]
        ret.sort()
        return ret

%}


%define DIR_EXTEND(classname)
    %extend classname {
        %pythoncode %{
            __dir__ = _dir_filter
        %}
    }
%enddef

DIR_EXTEND(b2AABB);
DIR_EXTEND(b2AssertException);
DIR_EXTEND(b2Body);
DIR_EXTEND(b2BodyDef);
DIR_EXTEND(b2BroadPhase);
DIR_EXTEND(b2CircleShape);
DIR_EXTEND(b2ClipVertex);
DIR_EXTEND(b2Color);
DIR_EXTEND(b2Contact);
DIR_EXTEND(b2ContactEdge);
DIR_EXTEND(b2ContactFeature);
DIR_EXTEND(b2ContactFilter);
DIR_EXTEND(b2ContactID);
DIR_EXTEND(b2ContactImpulse);
DIR_EXTEND(b2ContactListener);
DIR_EXTEND(b2ContactManager);
DIR_EXTEND(b2ContactPoint);
DIR_EXTEND(b2DestructionListener);
DIR_EXTEND(b2DistanceInput);
DIR_EXTEND(b2DistanceJoint);
DIR_EXTEND(b2DistanceJointDef);
DIR_EXTEND(b2DistanceOutput);
DIR_EXTEND(b2DistanceProxy);
DIR_EXTEND(b2Draw);
DIR_EXTEND(b2DrawExtended);
DIR_EXTEND(b2EdgeShape);
DIR_EXTEND(b2Filter);
DIR_EXTEND(b2Fixture);
DIR_EXTEND(b2FixtureDef);
DIR_EXTEND(b2FixtureProxy);
DIR_EXTEND(b2FrictionJoint);
DIR_EXTEND(b2FrictionJointDef);
DIR_EXTEND(b2GearJoint);
DIR_EXTEND(b2GearJointDef);
DIR_EXTEND(b2Jacobian);
DIR_EXTEND(b2Joint);
DIR_EXTEND(b2JointDef);
DIR_EXTEND(b2JointEdge);
DIR_EXTEND(b2WheelJoint);
DIR_EXTEND(b2WheelJointDef);
DIR_EXTEND(b2LoopShape);
DIR_EXTEND(b2Manifold);
DIR_EXTEND(b2ManifoldPoint);
DIR_EXTEND(b2MassData);
DIR_EXTEND(b2Mat22);
DIR_EXTEND(b2Mat33);
DIR_EXTEND(b2MouseJoint);
DIR_EXTEND(b2MouseJointDef);
DIR_EXTEND(b2Pair);
DIR_EXTEND(b2PolygonShape);
DIR_EXTEND(b2PrismaticJoint);
DIR_EXTEND(b2PrismaticJointDef);
DIR_EXTEND(b2PulleyJoint);
DIR_EXTEND(b2PulleyJointDef);
DIR_EXTEND(b2QueryCallback);
DIR_EXTEND(b2RayCastCallback);
DIR_EXTEND(b2RayCastInput);
DIR_EXTEND(b2RayCastOutput);
DIR_EXTEND(b2RevoluteJoint);
DIR_EXTEND(b2RevoluteJointDef);
DIR_EXTEND(b2RopeJoint);
DIR_EXTEND(b2RopeJointDef);
DIR_EXTEND(b2Shape);
DIR_EXTEND(b2Sweep);
DIR_EXTEND(b2TOIInput);
DIR_EXTEND(b2TOIOutput);
DIR_EXTEND(b2Transform);
DIR_EXTEND(b2Vec2);
DIR_EXTEND(b2Vec3);
DIR_EXTEND(b2Version);
DIR_EXTEND(b2WeldJoint);
DIR_EXTEND(b2WeldJointDef);
DIR_EXTEND(b2World);
DIR_EXTEND(b2WorldManifold);
