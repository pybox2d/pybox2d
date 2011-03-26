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
_format_recursed=0
def _format_repr(item, props, indent_amount=4, max_level=4, max_str_len=250, max_sub_lines=10):
    global _format_recursed
    _format_recursed+=1
    indent_str=' ' * (_format_recursed*indent_amount) 
    ret=['%s(' % item.__class__.__name__]

    #ret.append(str(_format_recursed))
    if _format_recursed > max_level:
        _format_recursed-=1
        return indent_str + '(*recursion*)'
    
    for prop in props:
        try:
            s=repr(getattr(item, prop))
        except Exception as ex:
            s='(*repr failed: %s*)' % ex

        if s.count('\n') > max_sub_lines:
            length=0
            for i, line in enumerate(s.split('\n')[:max_sub_lines]):
                length+=len(line)
                if length > max_str_len:
                    ending_delim=''
                    for j in s[::-1]:
                        if j in ')]}':
                            ending_delim+=j
                        else:
                            break
                    ret[-1]+='(...) %s' % ending_delim[::-1]
                    break

                if i==0:
                    ret.append('%s=%s' % (prop, line))
                else:
                    ret.append(line) 
        else:
            if '\n' in s:
                toadd=s.split('\n')
                ret.append('%s=%s' % (prop, toadd[0]))
                ret.extend(toadd[1:])
            else:
                ret.append('%s=%s,' % (prop, s))
    
    separator='\n%s' % indent_str
    _format_recursed-=1
    
    if len(ret) <= 3:
        ret[-1]+=')'
        if _format_recursed==0:
            return ''.join(ret)
        else:
            return [''.join(ret)]
    else:
        ret.append(')')
        return separator.join(ret)
%}

%extend b2AABB {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['center','extents','lowerBound','perimeter','upperBound','valid']) 
    %}
}
%extend b2AssertException {
    %pythoncode %{
        def __repr__(self):
            return "b2AssertException()"
    %}
}
%extend b2Body {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','angle','angularDamping','angularVelocity','awake','bullet','contacts','fixedRotation','fixtures','inertia','joints','linearDamping','linearVelocity','localCenter','mass','massData','position','sleepingAllowed','transform','type','userData','worldCenter']) 
    %}
}
%extend b2BodyDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','allowSleep','angle','angularDamping','angularVelocity','awake','bullet','fixedRotation','fixtures','inertiaScale','linearDamping','linearVelocity','position','shapeFixture','shapes','type','userData']) 
    %}
}
%extend b2BroadPhase {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['proxyCount']) 
    %}
}
%extend b2CircleShape {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['childCount','pos','radius','type']) 
    %}
}
%extend b2ClipVertex {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['id','v']) 
    %}
}
%extend b2Color {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['b','bytes','g','list','r']) 
    %}
}
%extend b2Contact {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['childIndexA','childIndexB','enabled','fixtureA','fixtureB','manifold','touching','worldManifold']) 
    %}
}
%extend b2ContactEdge {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['contact','other']) 
    %}
}
%extend b2ContactFeature {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['indexA','indexB','typeA','typeB']) 
    %}
}
%extend b2ContactFilter {
    %pythoncode %{
        def __repr__(self):
            return "b2ContactFilter()"
    %}
}
%extend b2ContactID {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['cf','key']) 
    %}
}
%extend b2ContactImpulse {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['normalImpulses','tangentImpulses']) 
    %}
}
%extend b2ContactListener {
    %pythoncode %{
        def __repr__(self):
            return "b2ContactListener()"
    %}
}
%extend b2ContactManager {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['allocator','broadPhase','contactCount','contactFilter','contactList','contactListener']) 
    %}
}
%extend b2ContactPoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['fixtureA','fixtureB','normal','position','state']) 
    %}
}
%extend b2DestructionListener {
    %pythoncode %{
        def __repr__(self):
            return "b2DestructionListener()"
    %}
}
%extend b2DistanceInput {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['proxyA','proxyB','transformA','transformB','useRadii']) 
    %}
}
%extend b2DistanceJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','dampingRatio','frequency','length','type','userData']) 
    %}
}
%extend b2DistanceJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchorA','anchorB','bodyA','bodyB','collideConnected','dampingRatio','frequencyHz','length','localAnchorA','localAnchorB','type','userData']) 
    %}
}
%extend b2DistanceOutput {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['distance','iterations','pointA','pointB']) 
    %}
}
%extend b2DistanceProxy {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['m_buffer','shape','vertices']) 
    %}
}
%extend b2Draw {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['flags']) 
    %}
}
%extend b2DrawExtended {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['center','convertVertices','flags','flipX','flipY','offset','screenSize','zoom']) 
    %}
}
%extend b2EdgeShape {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['all_vertices','childCount','hasVertex0','hasVertex3','radius','type','vertex0','vertex1','vertex2','vertex3','vertexCount','vertices']) 
    %}
}
%extend b2Filter {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['categoryBits','groupIndex','maskBits']) 
    %}
}
%extend b2Fixture {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['body','density','filterData','friction','massData','restitution','sensor','shape','type','userData']) 
    %}
}
%extend b2FixtureDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['categoryBits','density','filter','friction','groupIndex','isSensor','maskBits','restitution','shape','userData']) 
    %}
}
%extend b2FixtureProxy {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['aabb','childIndex','fixture','proxyId']) 
    %}
}
%extend b2FrictionJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','maxForce','maxTorque','type','userData']) 
    %}
}
%extend b2FrictionJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchor','bodyA','bodyB','collideConnected','localAnchorA','localAnchorB','maxForce','maxTorque','type','userData']) 
    %}
}
%extend b2GearJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','ratio','type','userData']) 
    %}
}
%extend b2GearJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['bodyA','bodyB','collideConnected','joint1','joint2','ratio','type','userData']) 
    %}
}
%extend b2Jacobian {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['angularA','angularB','linearA','linearB']) 
    %}
}
%extend b2Joint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','type','userData']) 
    %}
}
%extend b2JointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['bodyA','bodyB','collideConnected','type','userData']) 
    %}
}
%extend b2JointEdge {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['joint','other']) 
    %}
}
%extend b2WheelJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','maxMotorTorque','motorEnabled','motorSpeed','speed','springDampingRatio','springFrequencyHz','translation','type','userData']) 
    %}
}
%extend b2WheelJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchor','axis','bodyA','bodyB','collideConnected','dampingRatio','enableMotor','frequencyHz','localAnchorA','localAnchorB','localAxisA','maxMotorTorque','motorSpeed','type','userData']) 
    %}
}
%extend b2LoopShape {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['childCount','edges','radius','type','vertexCount','vertices']) 
    %}
}
%extend b2Manifold {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['localNormal','localPoint','pointCount','points','type_']) 
    %}
}
%extend b2ManifoldPoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['id','isNew','localPoint','normalImpulse','tangentImpulse']) 
    %}
}
%extend b2MassData {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['I','center','mass']) 
    %}
}
%extend b2Mat22 {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['angle','col1','col2','inverse']) 
    %}
}
%extend b2Mat33 {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['col1','col2','col3']) 
    %}
}
%extend b2MouseJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','dampingRatio','frequency','maxForce','target','type','userData']) 
    %}
}
%extend b2MouseJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['bodyA','bodyB','collideConnected','dampingRatio','frequencyHz','maxForce','target','type','userData']) 
    %}
}
%extend b2Pair {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['proxyIdA','proxyIdB']) 
    %}
}
%extend b2PolygonShape {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['box','centroid','childCount','normals','radius','type','valid','vertexCount','vertices']) 
    %}
}
%extend b2PrismaticJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','limitEnabled','limits','lowerLimit','maxMotorForce','motorEnabled','motorSpeed','speed','translation','type','upperLimit','userData']) 
    %}
}
%extend b2PrismaticJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchor','axis','bodyA','bodyB','collideConnected','enableLimit','enableMotor','localAnchorA','localAnchorB','localAxis1','lowerTranslation','maxMotorForce','motorSpeed','referenceAngle','type','upperTranslation','userData']) 
    %}
}
%extend b2PulleyJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','groundAnchorA','groundAnchorB','length1','length2','ratio','type','userData']) 
    %}
}
%extend b2PulleyJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchorA','anchorB','bodyA','bodyB','collideConnected','groundAnchorA','groundAnchorB','lengthA','lengthB','localAnchorA','localAnchorB','maxLengthA','maxLengthB','ratio','type','userData']) 
    %}
}
%extend b2QueryCallback {
    %pythoncode %{
        def __repr__(self):
            return "b2QueryCallback()"
    %}
}
%extend b2RayCastCallback {
    %pythoncode %{
        def __repr__(self):
            return "b2RayCastCallback()"
    %}
}
%extend b2RayCastInput {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['maxFraction','p1','p2']) 
    %}
}
%extend b2RayCastOutput {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['fraction','normal']) 
    %}
}
%extend b2RevoluteJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','angle','bodyA','bodyB','limitEnabled','limits','lowerLimit','maxMotorTorque','motorEnabled','motorSpeed','speed','type','upperLimit','userData']) 
    %}
}
%extend b2RevoluteJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchor','bodyA','bodyB','collideConnected','enableLimit','enableMotor','localAnchorA','localAnchorB','lowerAngle','maxMotorTorque','motorSpeed','referenceAngle','type','upperAngle','userData']) 
    %}
}
%extend b2RopeJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','limitState','maxLength','type','userData']) 
    %}
}
%extend b2RopeJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchorA','anchorB','bodyA','bodyB','collideConnected','localAnchorA','localAnchorB','maxLength','type','userData']) 
    %}
}
%extend b2Shape {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['childCount','radius','type']) 
    %}
}
%extend b2Sweep {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['a','a0','alpha0','c','c0','localCenter']) 
    %}
}
%extend b2TOIInput {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['proxyA','proxyB','sweepA','sweepB','tMax']) 
    %}
}
%extend b2TOIOutput {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['state','t']) 
    %}
}
%extend b2Transform {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['R','angle','position']) 
    %}
}
%extend b2Vec2 {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['length','lengthSquared','skew','tuple','valid','x','y']) 
    %}
}
%extend b2Vec3 {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['length','lengthSquared','tuple','valid','x','y','z']) 
    %}
}
%extend b2Version {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['major','minor','revision']) 
    %}
}
%extend b2WeldJoint {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['active','anchorA','anchorB','bodyA','bodyB','type','userData']) 
    %}
}
%extend b2WeldJointDef {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['anchor','bodyA','bodyB','collideConnected','localAnchorA','localAnchorB','referenceAngle','type','userData']) 
    %}
}
%extend b2World {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['autoClearForces','bodies','bodyCount','contactCount','contactFilter','contactListener','contactManager','contacts','continuousPhysics','destructionListener','gravity','jointCount','joints','locked','proxyCount','renderer','subStepping','warmStarting']) 
    %}
}
%extend b2WorldManifold {
    %pythoncode %{
        def __repr__(self):
            return _format_repr(self, ['normal','points']) 
    %}
}
