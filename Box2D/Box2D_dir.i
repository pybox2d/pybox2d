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
        # Using introspection, mimic dir() by adding up all of the __dicts__
        # for the current class and all base classes (type(self).__mro__ returns
        # all of the classes that make it up)
        # Basically filters by:
        # __x__ OK
        # __x bad
        # _classname bad
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
        
        keys=sum([list(c.__dict__.keys()) for c in type(self).__mro__], [])
        typenames=["_%s" % c.__name__ for c in type(self).__mro__]
        ret=[s for s in list(set(keys)) if check(s)]
        ret.sort()
        return ret

%}


%extend b2AABB {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}

%extend b2Body {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2BodyDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2CircleShape {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ClipVertex {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Color {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Contact {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ContactEdge {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ContactFilter {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ContactID {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ContactImpulse {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ContactListener {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Draw {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2DestructionListener {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2DistanceInput {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2DistanceProxy {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2DistanceJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2DistanceJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2DistanceOutput {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}



%extend b2Filter {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Fixture {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2FixtureDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2FrictionJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2FrictionJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2GearJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2GearJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Jacobian {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Joint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2JointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2JointEdge {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2WheelJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2WheelJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Manifold {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2ManifoldPoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2MassData {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Mat22 {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Mat33 {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2MouseJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2MouseJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Pair {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2PolygonShape {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2PrismaticJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2PrismaticJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2PulleyJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2PulleyJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2QueryCallback {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2RayCastCallback {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2RayCastInput {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2RayCastOutput {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2RevoluteJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2RevoluteJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}

%extend b2RopeJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2RopeJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Shape {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Sweep {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2TOIInput {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Transform {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Vec2 {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Vec3 {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2Version {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2WeldJoint {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2WeldJointDef {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2World {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}


%extend b2WorldManifold {
    %pythoncode %{
        __dir__ = _dir_filter
    %}
}

