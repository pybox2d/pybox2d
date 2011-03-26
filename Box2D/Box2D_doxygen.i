
// File: index.xml

// File: structb2_a_a_b_b.xml
%feature("docstring") b2AABB "An axis aligned bounding box.";

%feature("docstring") b2AABB::IsValid "Verify that the bounds are sorted.";

%feature("docstring") b2AABB::GetCenter "Get the center of the AABB.";

%feature("docstring") b2AABB::GetExtents "Get the extents of the AABB (half-widths).";

%feature("docstring") b2AABB::GetPerimeter "Get the perimeter length.";

%feature("docstring") b2AABB::Combine "Combine an AABB into this one.";

%feature("docstring") b2AABB::Combine "Combine two AABBs into this one.";

%feature("docstring") b2AABB::Contains "Does this aabb contain the provided AABB.";

%feature("docstring") b2AABB::IsValid "Verify that the bounds are sorted.";

%feature("docstring") b2AABB::GetCenter "Get the center of the AABB.";

%feature("docstring") b2AABB::GetExtents "Get the extents of the AABB (half-widths).";

%feature("docstring") b2AABB::GetPerimeter "Get the perimeter length.";

%feature("docstring") b2AABB::Combine "Combine an AABB into this one.";

%feature("docstring") b2AABB::Combine "Combine two AABBs into this one.";

%feature("docstring") b2AABB::Contains "Does this aabb contain the provided AABB.";


// File: classb2_block_allocator.xml
%feature("docstring") b2BlockAllocator "This is a small object allocator used for allocating small objects that persist for more than one time step. See: http://www.codeproject.com/useritems/Small_Block_Allocator.asp";

%feature("docstring") b2BlockAllocator::Allocate "Allocate memory. This will use b2Alloc if the size is larger than b2_maxBlockSize.";

%feature("docstring") b2BlockAllocator::Free "Free memory. This will use b2Free if the size is larger than b2_maxBlockSize.";

%feature("docstring") b2BlockAllocator::Allocate "Allocate memory. This will use b2Alloc if the size is larger than b2_maxBlockSize.";

%feature("docstring") b2BlockAllocator::Free "Free memory. This will use b2Free if the size is larger than b2_maxBlockSize.";


// File: classb2_body.xml
%feature("docstring") b2Body "A rigid body. These are created via  b2World::CreateBody.";

%feature("docstring") b2Body::CreateFixture "Creates a fixture and attach it to this body. Use this function if you need to set some fixture parameters, like friction. Otherwise you can create the fixture directly from a shape. If the density is non-zero, this function automatically updates the mass of the body. Contacts are not created until the next time step.

Parameters:
-----------

def: 
the fixture definition.

WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2Body::CreateFixture "Creates a fixture from a shape and attach it to this body. This is a convenience function. Use  b2FixtureDefif you need to set parameters like friction, restitution, user data, or filtering. If the density is non-zero, this function automatically updates the mass of the body.

Parameters:
-----------

shape: 
the shape to be cloned.

density: 
the shape density (set to zero for static bodies).

WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2Body::DestroyFixture "Destroy a fixture. This removes the fixture from the broad-phase and destroys all contacts associated with this fixture. This will automatically adjust the mass of the body if the body is dynamic and the fixture has positive density. All fixtures attached to a body are implicitly destroyed when the body is destroyed.

Parameters:
-----------

fixture: 
the fixture to be removed.

WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2Body::SetTransform "Set the position of the body's origin and rotation. This breaks any contacts and wakes the other bodies. Manipulating a body's transform may cause non-physical behavior.

Parameters:
-----------

position: 
the world position of the body's local origin.

angle: 
the world rotation in radians.";

%feature("docstring") b2Body::GetTransform "Get the body transform for the body's origin. 
the world transform of the body's origin.";

%feature("docstring") b2Body::GetPosition "Get the world body origin position. 
the world position of the body's origin.";

%feature("docstring") b2Body::GetAngle "Get the angle in radians. 
the current world rotation angle in radians.";

%feature("docstring") b2Body::GetWorldCenter "Get the world position of the center of mass.";

%feature("docstring") b2Body::GetLocalCenter "Get the local position of the center of mass.";

%feature("docstring") b2Body::SetLinearVelocity "Set the linear velocity of the center of mass.

Parameters:
-----------

v: 
the new linear velocity of the center of mass.";

%feature("docstring") b2Body::GetLinearVelocity "Get the linear velocity of the center of mass. 
the linear velocity of the center of mass.";

%feature("docstring") b2Body::SetAngularVelocity "Set the angular velocity.

Parameters:
-----------

omega: 
the new angular velocity in radians/second.";

%feature("docstring") b2Body::GetAngularVelocity "Get the angular velocity. 
the angular velocity in radians/second.";

%feature("docstring") b2Body::ApplyForce "Apply a force at a world point. If the force is not applied at the center of mass, it will generate a torque and affect the angular velocity. This wakes up the body.

Parameters:
-----------

force: 
the world force vector, usually in Newtons (N).

point: 
the world position of the point of application.";

%feature("docstring") b2Body::ApplyTorque "Apply a torque. This affects the angular velocity without affecting the linear velocity of the center of mass. This wakes up the body.

Parameters:
-----------

torque: 
about the z-axis (out of the screen), usually in N-m.";

%feature("docstring") b2Body::ApplyLinearImpulse "Apply an impulse at a point. This immediately modifies the velocity. It also modifies the angular velocity if the point of application is not at the center of mass. This wakes up the body.

Parameters:
-----------

impulse: 
the world impulse vector, usually in N-seconds or kg-m/s.

point: 
the world position of the point of application.";

%feature("docstring") b2Body::ApplyAngularImpulse "Apply an angular impulse.

Parameters:
-----------

impulse: 
the angular impulse in units of kg*m*m/s";

%feature("docstring") b2Body::GetMass "Get the total mass of the body. 
the mass, usually in kilograms (kg).";

%feature("docstring") b2Body::GetInertia "Get the rotational inertia of the body about the local origin. 
the rotational inertia, usually in kg-m^2.";

%feature("docstring") b2Body::GetMassData "Get the mass data of the body. 
a struct containing the mass, inertia and center of the body.";

%feature("docstring") b2Body::SetMassData "Set the mass properties to override the mass properties of the fixtures. Note that this changes the center of mass position. Note that creating or destroying fixtures can also alter the mass. This function has no effect if the body isn't dynamic.

Parameters:
-----------

massData: 
the mass properties.";

%feature("docstring") b2Body::ResetMassData "This resets the mass properties to the sum of the mass properties of the fixtures. This normally does not need to be called unless you called SetMassData to override the mass and you later want to reset the mass.";

%feature("docstring") b2Body::GetWorldPoint "Get the world coordinates of a point given the local coordinates.

Parameters:
-----------

localPoint: 
a point on the body measured relative the the body's origin. 
the same point expressed in world coordinates.";

%feature("docstring") b2Body::GetWorldVector "Get the world coordinates of a vector given the local coordinates.

Parameters:
-----------

localVector: 
a vector fixed in the body. 
the same vector expressed in world coordinates.";

%feature("docstring") b2Body::GetLocalPoint "Gets a local point relative to the body's origin given a world point.

Parameters:
-----------

a: 
point in world coordinates. 
the corresponding local point relative to the body's origin.";

%feature("docstring") b2Body::GetLocalVector "Gets a local vector given a world vector.

Parameters:
-----------

a: 
vector in world coordinates. 
the corresponding local vector.";

%feature("docstring") b2Body::GetLinearVelocityFromWorldPoint "Get the world linear velocity of a world point attached to this body.

Parameters:
-----------

a: 
point in world coordinates. 
the world velocity of a point.";

%feature("docstring") b2Body::GetLinearVelocityFromLocalPoint "Get the world velocity of a local point.

Parameters:
-----------

a: 
point in local coordinates. 
the world velocity of a point.";

%feature("docstring") b2Body::GetLinearDamping "Get the linear damping of the body.";

%feature("docstring") b2Body::SetLinearDamping "Set the linear damping of the body.";

%feature("docstring") b2Body::GetAngularDamping "Get the angular damping of the body.";

%feature("docstring") b2Body::SetAngularDamping "Set the angular damping of the body.";

%feature("docstring") b2Body::SetType "Set the type of this body. This may alter the mass and velocity.";

%feature("docstring") b2Body::GetType "Get the type of this body.";

%feature("docstring") b2Body::SetBullet "Should this body be treated like a bullet for continuous collision detection?";

%feature("docstring") b2Body::IsBullet "Is this body treated like a bullet for continuous collision detection?";

%feature("docstring") b2Body::SetSleepingAllowed "You can disable sleeping on this body. If you disable sleeping, the body will be woken.";

%feature("docstring") b2Body::IsSleepingAllowed "Is this body allowed to sleep.";

%feature("docstring") b2Body::SetAwake "Set the sleep state of the body. A sleeping body has very low CPU cost.

Parameters:
-----------

flag: 
set to true to put body to sleep, false to wake it.";

%feature("docstring") b2Body::IsAwake "Get the sleeping state of this body. 
true if the body is sleeping.";

%feature("docstring") b2Body::SetActive "Set the active state of the body. An inactive body is not simulated and cannot be collided with or woken up. If you pass a flag of true, all fixtures will be added to the broad-phase. If you pass a flag of false, all fixtures will be removed from the broad-phase and all contacts will be destroyed. Fixtures and joints are otherwise unaffected. You may continue to create/destroy fixtures and joints on inactive bodies. Fixtures on an inactive body are implicitly inactive and will not participate in collisions, ray-casts, or queries. Joints connected to an inactive body are implicitly inactive. An inactive body is still owned by a  b2Worldobject and remains in the body list.";

%feature("docstring") b2Body::IsActive "Get the active state of the body.";

%feature("docstring") b2Body::SetFixedRotation "Set this body to have fixed rotation. This causes the mass to be reset.";

%feature("docstring") b2Body::IsFixedRotation "Does this body have fixed rotation?";

%feature("docstring") b2Body::GetFixtureList "Get the list of all fixtures attached to this body.";

%feature("docstring") b2Body::GetJointList "Get the list of all joints attached to this body.";

%feature("docstring") b2Body::GetContactList "Get the list of all contacts attached to this body. 
WARNING: 
this list changes during the time step and you may miss some collisions if you don't use  b2ContactListener.";

%feature("docstring") b2Body::GetNext "Get the next body in the world's body list.";

%feature("docstring") b2Body::GetUserData "Get the user data pointer that was provided in the body definition.";

%feature("docstring") b2Body::SetUserData "Set the user data. Use this to store your application specific data.";

%feature("docstring") b2Body::GetWorld "Get the parent world of this body.";

%feature("docstring") b2Body::CreateFixture "Creates a fixture and attach it to this body. Use this function if you need to set some fixture parameters, like friction. Otherwise you can create the fixture directly from a shape. If the density is non-zero, this function automatically updates the mass of the body. Contacts are not created until the next time step.

Parameters:
-----------

def: 
the fixture definition.

WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2Body::CreateFixture "Creates a fixture from a shape and attach it to this body. This is a convenience function. Use  b2FixtureDefif you need to set parameters like friction, restitution, user data, or filtering. If the density is non-zero, this function automatically updates the mass of the body.

Parameters:
-----------

shape: 
the shape to be cloned.

density: 
the shape density (set to zero for static bodies).

WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2Body::DestroyFixture "Destroy a fixture. This removes the fixture from the broad-phase and destroys all contacts associated with this fixture. This will automatically adjust the mass of the body if the body is dynamic and the fixture has positive density. All fixtures attached to a body are implicitly destroyed when the body is destroyed.

Parameters:
-----------

fixture: 
the fixture to be removed.

WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2Body::SetTransform "Set the position of the body's origin and rotation. This breaks any contacts and wakes the other bodies. Manipulating a body's transform may cause non-physical behavior.

Parameters:
-----------

position: 
the world position of the body's local origin.

angle: 
the world rotation in radians.";

%feature("docstring") b2Body::GetTransform "Get the body transform for the body's origin. 
the world transform of the body's origin.";

%feature("docstring") b2Body::GetPosition "Get the world body origin position. 
the world position of the body's origin.";

%feature("docstring") b2Body::GetAngle "Get the angle in radians. 
the current world rotation angle in radians.";

%feature("docstring") b2Body::GetWorldCenter "Get the world position of the center of mass.";

%feature("docstring") b2Body::GetLocalCenter "Get the local position of the center of mass.";

%feature("docstring") b2Body::SetLinearVelocity "Set the linear velocity of the center of mass.

Parameters:
-----------

v: 
the new linear velocity of the center of mass.";

%feature("docstring") b2Body::GetLinearVelocity "Get the linear velocity of the center of mass. 
the linear velocity of the center of mass.";

%feature("docstring") b2Body::SetAngularVelocity "Set the angular velocity.

Parameters:
-----------

omega: 
the new angular velocity in radians/second.";

%feature("docstring") b2Body::GetAngularVelocity "Get the angular velocity. 
the angular velocity in radians/second.";

%feature("docstring") b2Body::ApplyForce "Apply a force at a world point. If the force is not applied at the center of mass, it will generate a torque and affect the angular velocity. This wakes up the body.

Parameters:
-----------

force: 
the world force vector, usually in Newtons (N).

point: 
the world position of the point of application.";

%feature("docstring") b2Body::ApplyTorque "Apply a torque. This affects the angular velocity without affecting the linear velocity of the center of mass. This wakes up the body.

Parameters:
-----------

torque: 
about the z-axis (out of the screen), usually in N-m.";

%feature("docstring") b2Body::ApplyLinearImpulse "Apply an impulse at a point. This immediately modifies the velocity. It also modifies the angular velocity if the point of application is not at the center of mass. This wakes up the body.

Parameters:
-----------

impulse: 
the world impulse vector, usually in N-seconds or kg-m/s.

point: 
the world position of the point of application.";

%feature("docstring") b2Body::ApplyAngularImpulse "Apply an angular impulse.

Parameters:
-----------

impulse: 
the angular impulse in units of kg*m*m/s";

%feature("docstring") b2Body::GetMass "Get the total mass of the body. 
the mass, usually in kilograms (kg).";

%feature("docstring") b2Body::GetInertia "Get the rotational inertia of the body about the local origin. 
the rotational inertia, usually in kg-m^2.";

%feature("docstring") b2Body::GetMassData "Get the mass data of the body. 
a struct containing the mass, inertia and center of the body.";

%feature("docstring") b2Body::SetMassData "Set the mass properties to override the mass properties of the fixtures. Note that this changes the center of mass position. Note that creating or destroying fixtures can also alter the mass. This function has no effect if the body isn't dynamic.

Parameters:
-----------

massData: 
the mass properties.";

%feature("docstring") b2Body::ResetMassData "This resets the mass properties to the sum of the mass properties of the fixtures. This normally does not need to be called unless you called SetMassData to override the mass and you later want to reset the mass.";

%feature("docstring") b2Body::GetWorldPoint "Get the world coordinates of a point given the local coordinates.

Parameters:
-----------

localPoint: 
a point on the body measured relative the the body's origin. 
the same point expressed in world coordinates.";

%feature("docstring") b2Body::GetWorldVector "Get the world coordinates of a vector given the local coordinates.

Parameters:
-----------

localVector: 
a vector fixed in the body. 
the same vector expressed in world coordinates.";

%feature("docstring") b2Body::GetLocalPoint "Gets a local point relative to the body's origin given a world point.

Parameters:
-----------

a: 
point in world coordinates. 
the corresponding local point relative to the body's origin.";

%feature("docstring") b2Body::GetLocalVector "Gets a local vector given a world vector.

Parameters:
-----------

a: 
vector in world coordinates. 
the corresponding local vector.";

%feature("docstring") b2Body::GetLinearVelocityFromWorldPoint "Get the world linear velocity of a world point attached to this body.

Parameters:
-----------

a: 
point in world coordinates. 
the world velocity of a point.";

%feature("docstring") b2Body::GetLinearVelocityFromLocalPoint "Get the world velocity of a local point.

Parameters:
-----------

a: 
point in local coordinates. 
the world velocity of a point.";

%feature("docstring") b2Body::GetLinearDamping "Get the linear damping of the body.";

%feature("docstring") b2Body::SetLinearDamping "Set the linear damping of the body.";

%feature("docstring") b2Body::GetAngularDamping "Get the angular damping of the body.";

%feature("docstring") b2Body::SetAngularDamping "Set the angular damping of the body.";

%feature("docstring") b2Body::SetType "Set the type of this body. This may alter the mass and velocity.";

%feature("docstring") b2Body::GetType "Get the type of this body.";

%feature("docstring") b2Body::SetBullet "Should this body be treated like a bullet for continuous collision detection?";

%feature("docstring") b2Body::IsBullet "Is this body treated like a bullet for continuous collision detection?";

%feature("docstring") b2Body::SetSleepingAllowed "You can disable sleeping on this body. If you disable sleeping, the body will be woken.";

%feature("docstring") b2Body::IsSleepingAllowed "Is this body allowed to sleep.";

%feature("docstring") b2Body::SetAwake "Set the sleep state of the body. A sleeping body has very low CPU cost.

Parameters:
-----------

flag: 
set to true to put body to sleep, false to wake it.";

%feature("docstring") b2Body::IsAwake "Get the sleeping state of this body. 
true if the body is sleeping.";

%feature("docstring") b2Body::SetActive "Set the active state of the body. An inactive body is not simulated and cannot be collided with or woken up. If you pass a flag of true, all fixtures will be added to the broad-phase. If you pass a flag of false, all fixtures will be removed from the broad-phase and all contacts will be destroyed. Fixtures and joints are otherwise unaffected. You may continue to create/destroy fixtures and joints on inactive bodies. Fixtures on an inactive body are implicitly inactive and will not participate in collisions, ray-casts, or queries. Joints connected to an inactive body are implicitly inactive. An inactive body is still owned by a  b2Worldobject and remains in the body list.";

%feature("docstring") b2Body::IsActive "Get the active state of the body.";

%feature("docstring") b2Body::SetFixedRotation "Set this body to have fixed rotation. This causes the mass to be reset.";

%feature("docstring") b2Body::IsFixedRotation "Does this body have fixed rotation?";

%feature("docstring") b2Body::GetFixtureList "Get the list of all fixtures attached to this body.";

%feature("docstring") b2Body::GetJointList "Get the list of all joints attached to this body.";

%feature("docstring") b2Body::GetContactList "Get the list of all contacts attached to this body. 
WARNING: 
this list changes during the time step and you may miss some collisions if you don't use  b2ContactListener.";

%feature("docstring") b2Body::GetNext "Get the next body in the world's body list.";

%feature("docstring") b2Body::GetUserData "Get the user data pointer that was provided in the body definition.";

%feature("docstring") b2Body::SetUserData "Set the user data. Use this to store your application specific data.";

%feature("docstring") b2Body::GetWorld "Get the parent world of this body.";


// File: structb2_body_def.xml
%feature("docstring") b2BodyDef "A body definition holds all the data needed to construct a rigid body. You can safely re-use body definitions. Shapes are added to a body after construction.";

%feature("docstring") b2BodyDef::b2BodyDef "This constructor sets the body definition default values.";

%feature("docstring") b2BodyDef::b2BodyDef "This constructor sets the body definition default values.";


// File: classb2_broad_phase.xml
%feature("docstring") b2BroadPhase "The broad-phase is used for computing pairs and performing volume queries and ray casts. This broad-phase does not persist pairs. Instead, this reports potentially new pairs. It is up to the client to consume the new pairs and to track subsequent overlap.";

%feature("docstring") b2BroadPhase::CreateProxy "Create a proxy with an initial AABB. Pairs are not reported until UpdatePairs is called.";

%feature("docstring") b2BroadPhase::DestroyProxy "Destroy a proxy. It is up to the client to remove any pairs.";

%feature("docstring") b2BroadPhase::MoveProxy "Call MoveProxy as many times as you like, then when you are done call UpdatePairs to finalized the proxy pairs (for your time step).";

%feature("docstring") b2BroadPhase::TouchProxy "Call to trigger a re-processing of it's pairs on the next call to UpdatePairs.";

%feature("docstring") b2BroadPhase::GetFatAABB "Get the fat AABB for a proxy.";

%feature("docstring") b2BroadPhase::GetUserData "Get user data from a proxy. Returns NULL if the id is invalid.";

%feature("docstring") b2BroadPhase::TestOverlap "Test overlap of fat AABBs.";

%feature("docstring") b2BroadPhase::GetProxyCount "Get the number of proxies.";

%feature("docstring") b2BroadPhase::UpdatePairs "Update the pairs. This results in pair callbacks. This can only add pairs.";

%feature("docstring") b2BroadPhase::Query "Query an AABB for overlapping proxies. The callback class is called for each proxy that overlaps the supplied AABB.";

%feature("docstring") b2BroadPhase::RayCast "Ray-cast against the proxies in the tree. This relies on the callback to perform a exact ray-cast in the case were the proxy contains a shape. The callback also performs the any collision filtering. This has performance roughly equal to k * log(n), where k is the number of collisions and n is the number of proxies in the tree.

Parameters:
-----------

input: 
the ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).

callback: 
a callback class that is called for each proxy that is hit by the ray.";

%feature("docstring") b2BroadPhase::ComputeHeight "Compute the height of the embedded tree.";

%feature("docstring") b2BroadPhase::CreateProxy "Create a proxy with an initial AABB. Pairs are not reported until UpdatePairs is called.";

%feature("docstring") b2BroadPhase::DestroyProxy "Destroy a proxy. It is up to the client to remove any pairs.";

%feature("docstring") b2BroadPhase::MoveProxy "Call MoveProxy as many times as you like, then when you are done call UpdatePairs to finalized the proxy pairs (for your time step).";

%feature("docstring") b2BroadPhase::TouchProxy "Call to trigger a re-processing of it's pairs on the next call to UpdatePairs.";

%feature("docstring") b2BroadPhase::GetFatAABB "Get the fat AABB for a proxy.";

%feature("docstring") b2BroadPhase::GetUserData "Get user data from a proxy. Returns NULL if the id is invalid.";

%feature("docstring") b2BroadPhase::TestOverlap "Test overlap of fat AABBs.";

%feature("docstring") b2BroadPhase::GetProxyCount "Get the number of proxies.";

%feature("docstring") b2BroadPhase::UpdatePairs "Update the pairs. This results in pair callbacks. This can only add pairs.";

%feature("docstring") b2BroadPhase::Query "Query an AABB for overlapping proxies. The callback class is called for each proxy that overlaps the supplied AABB.";

%feature("docstring") b2BroadPhase::RayCast "Ray-cast against the proxies in the tree. This relies on the callback to perform a exact ray-cast in the case were the proxy contains a shape. The callback also performs the any collision filtering. This has performance roughly equal to k * log(n), where k is the number of collisions and n is the number of proxies in the tree.

Parameters:
-----------

input: 
the ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).

callback: 
a callback class that is called for each proxy that is hit by the ray.";

%feature("docstring") b2BroadPhase::ComputeHeight "Compute the height of the embedded tree.";


// File: classb2_circle_shape.xml
%feature("docstring") b2CircleShape "A circle shape.";

%feature("docstring") b2CircleShape::Clone "Implement  b2Shape.";

%feature("docstring") b2CircleShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2CircleShape::TestPoint "Implement  b2Shape.";

%feature("docstring") b2CircleShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2CircleShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2CircleShape::ComputeMass "

See: 
 b2Shape::ComputeMass";

%feature("docstring") b2CircleShape::GetSupport "Get the supporting vertex index in the given direction.";

%feature("docstring") b2CircleShape::GetSupportVertex "Get the supporting vertex in the given direction.";

%feature("docstring") b2CircleShape::GetVertexCount "Get the vertex count.";

%feature("docstring") b2CircleShape::GetVertex "Get a vertex by index. Used by b2Distance.";

%feature("docstring") b2CircleShape::Clone "Implement  b2Shape.";

%feature("docstring") b2CircleShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2CircleShape::TestPoint "Implement  b2Shape.";

%feature("docstring") b2CircleShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2CircleShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2CircleShape::ComputeMass "

See: 
 b2Shape::ComputeMass";

%feature("docstring") b2CircleShape::GetSupport "Get the supporting vertex index in the given direction.";

%feature("docstring") b2CircleShape::GetSupportVertex "Get the supporting vertex in the given direction.";

%feature("docstring") b2CircleShape::GetVertexCount "Get the vertex count.";

%feature("docstring") b2CircleShape::GetVertex "Get a vertex by index. Used by b2Distance.";


// File: structb2_clip_vertex.xml
%feature("docstring") b2ClipVertex "Used for computing contact manifolds.";


// File: structb2_color.xml
%feature("docstring") b2Color "Color for debug drawing. Each value has the range [0,1].";


// File: classb2_contact.xml
%feature("docstring") b2Contact "The class manages contact between two shapes. A contact exists for each overlapping AABB in the broad-phase (except if filtered). Therefore a contact object may exist that has no contact points.";

%feature("docstring") b2Contact::GetManifold "Get the contact manifold. Do not modify the manifold unless you understand the internals of Box2D.";

%feature("docstring") b2Contact::GetWorldManifold "Get the world manifold.";

%feature("docstring") b2Contact::IsTouching "Is this contact touching?";

%feature("docstring") b2Contact::SetEnabled "Enable/disable this contact. This can be used inside the pre-solve contact listener. The contact is only disabled for the current time step (or sub-step in continuous collisions).";

%feature("docstring") b2Contact::IsEnabled "Has this contact been disabled?";

%feature("docstring") b2Contact::GetNext "Get the next contact in the world's contact list.";

%feature("docstring") b2Contact::GetFixtureA "Get fixture A in this contact.";

%feature("docstring") b2Contact::GetChildIndexA "Get the child primitive index for fixture A.";

%feature("docstring") b2Contact::GetFixtureB "Get fixture B in this contact.";

%feature("docstring") b2Contact::GetChildIndexB "Get the child primitive index for fixture B.";

%feature("docstring") b2Contact::SetFriction "Override the default friction mixture. You can call this in  b2ContactListener::PreSolve. This value persists until set or reset.";

%feature("docstring") b2Contact::GetFriction "Get the friction.";

%feature("docstring") b2Contact::ResetFriction "Reset the friction mixture to the default value.";

%feature("docstring") b2Contact::SetRestitution "Override the default restitution mixture. You can call this in  b2ContactListener::PreSolve. The value persists until you set or reset.";

%feature("docstring") b2Contact::GetRestitution "Get the restitution.";

%feature("docstring") b2Contact::ResetRestitution "Reset the restitution to the default value.";

%feature("docstring") b2Contact::Evaluate "Evaluate this contact with your own manifold and transforms.";

%feature("docstring") b2Contact::GetManifold "Get the contact manifold. Do not modify the manifold unless you understand the internals of Box2D.";

%feature("docstring") b2Contact::GetWorldManifold "Get the world manifold.";

%feature("docstring") b2Contact::IsTouching "Is this contact touching?";

%feature("docstring") b2Contact::SetEnabled "Enable/disable this contact. This can be used inside the pre-solve contact listener. The contact is only disabled for the current time step (or sub-step in continuous collisions).";

%feature("docstring") b2Contact::IsEnabled "Has this contact been disabled?";

%feature("docstring") b2Contact::GetNext "Get the next contact in the world's contact list.";

%feature("docstring") b2Contact::GetFixtureA "Get fixture A in this contact.";

%feature("docstring") b2Contact::GetChildIndexA "Get the child primitive index for fixture A.";

%feature("docstring") b2Contact::GetFixtureB "Get fixture B in this contact.";

%feature("docstring") b2Contact::GetChildIndexB "Get the child primitive index for fixture B.";

%feature("docstring") b2Contact::Evaluate "Evaluate this contact with your own manifold and transforms.";


// File: structb2_contact_edge.xml
%feature("docstring") b2ContactEdge "A contact edge is used to connect bodies and contacts together in a contact graph where each body is a node and each contact is an edge. A contact edge belongs to a doubly linked list maintained in each attached body. Each contact has two contact nodes, one for each attached body.";


// File: structb2_contact_feature.xml
%feature("docstring") b2ContactFeature "The features that intersect to form the contact point This must be 4 bytes or less.";


// File: classb2_contact_filter.xml
%feature("docstring") b2ContactFilter "Implement this class to provide collision filtering. In other words, you can implement this class if you want finer control over contact creation.";

%feature("docstring") b2ContactFilter::ShouldCollide "Return true if contact calculations should be performed between these two shapes. 
WARNING: 
for performance reasons this is only called when the AABBs begin to overlap.";

%feature("docstring") b2ContactFilter::ShouldCollide "Return true if contact calculations should be performed between these two shapes. 
WARNING: 
for performance reasons this is only called when the AABBs begin to overlap.";


// File: structb2_contact_impulse.xml
%feature("docstring") b2ContactImpulse "Contact impulses for reporting. Impulses are used instead of forces because sub-step forces may approach infinity for rigid body collisions. These match up one-to-one with the contact points in  b2Manifold.";


// File: classb2_contact_listener.xml
%feature("docstring") b2ContactListener "Implement this class to get contact information. You can use these results for things like sounds and game logic. You can also get contact results by traversing the contact lists after the time step. However, you might miss some contacts because continuous physics leads to sub-stepping. Additionally you may receive multiple callbacks for the same contact in a single time step. You should strive to make your callbacks efficient because there may be many callbacks per time step. 
WARNING: 
You cannot create/destroy Box2D entities inside these callbacks.";

%feature("docstring") b2ContactListener::BeginContact "Called when two fixtures begin to touch.";

%feature("docstring") b2ContactListener::EndContact "Called when two fixtures cease to touch.";

%feature("docstring") b2ContactListener::PreSolve "This is called after a contact is updated. This allows you to inspect a contact before it goes to the solver. If you are careful, you can modify the contact manifold (e.g. disable contact). A copy of the old manifold is provided so that you can detect changes. Note: this is called only for awake bodies. Note: this is called even when the number of contact points is zero. Note: this is not called for sensors. Note: if you set the number of contact points to zero, you will not get an EndContact callback. However, you may get a BeginContact callback the next step.";

%feature("docstring") b2ContactListener::PostSolve "This lets you inspect a contact after the solver is finished. This is useful for inspecting impulses. Note: the contact manifold does not include time of impact impulses, which can be arbitrarily large if the sub-step is small. Hence the impulse is provided explicitly in a separate data structure. Note: this is only called for contacts that are touching, solid, and awake.";

%feature("docstring") b2ContactListener::BeginContact "Called when two fixtures begin to touch.";

%feature("docstring") b2ContactListener::EndContact "Called when two fixtures cease to touch.";

%feature("docstring") b2ContactListener::PreSolve "This is called after a contact is updated. This allows you to inspect a contact before it goes to the solver. If you are careful, you can modify the contact manifold (e.g. disable contact). A copy of the old manifold is provided so that you can detect changes. Note: this is called only for awake bodies. Note: this is called even when the number of contact points is zero. Note: this is not called for sensors. Note: if you set the number of contact points to zero, you will not get an EndContact callback. However, you may get a BeginContact callback the next step.";

%feature("docstring") b2ContactListener::PostSolve "This lets you inspect a contact after the solver is finished. This is useful for inspecting impulses. Note: the contact manifold does not include time of impact impulses, which can be arbitrarily large if the sub-step is small. Hence the impulse is provided explicitly in a separate data structure. Note: this is only called for contacts that are touching, solid, and awake.";


// File: classb2_destruction_listener.xml
%feature("docstring") b2DestructionListener "Joints and fixtures are destroyed when their associated body is destroyed. Implement this listener so that you may nullify references to these joints and shapes.";

%feature("docstring") b2DestructionListener::SayGoodbye "Called when any joint is about to be destroyed due to the destruction of one of its attached bodies.";

%feature("docstring") b2DestructionListener::SayGoodbye "Called when any fixture is about to be destroyed due to the destruction of its parent body.";

%feature("docstring") b2DestructionListener::SayGoodbye "Called when any joint is about to be destroyed due to the destruction of one of its attached bodies.";

%feature("docstring") b2DestructionListener::SayGoodbye "Called when any fixture is about to be destroyed due to the destruction of its parent body.";


// File: structb2_distance_input.xml
%feature("docstring") b2DistanceInput "Input for b2Distance. You have to option to use the shape radii in the computation. Even";


// File: classb2_distance_joint.xml
%feature("docstring") b2DistanceJoint "A distance joint constrains two points on two bodies to remain at a fixed distance from each other. You can view this as a massless, rigid rod.";

%feature("docstring") b2DistanceJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2DistanceJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2DistanceJoint::GetReactionForce "Get the reaction force given the inverse time step. Unit is N.";

%feature("docstring") b2DistanceJoint::GetReactionTorque "Get the reaction torque given the inverse time step. Unit is N*m. This is always zero for a distance joint.";

%feature("docstring") b2DistanceJoint::SetLength "Set/get the natural length. Manipulating the length can lead to non-physical behavior when the frequency is zero.";

%feature("docstring") b2DistanceJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2DistanceJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2DistanceJoint::GetReactionForce "Get the reaction force given the inverse time step. Unit is N.";

%feature("docstring") b2DistanceJoint::GetReactionTorque "Get the reaction torque given the inverse time step. Unit is N*m. This is always zero for a distance joint.";

%feature("docstring") b2DistanceJoint::SetLength "Set/get the natural length. Manipulating the length can lead to non-physical behavior when the frequency is zero.";


// File: structb2_distance_joint_def.xml
%feature("docstring") b2DistanceJointDef "Distance joint definition. This requires defining an anchor point on both bodies and the non-zero length of the distance joint. The definition uses local anchor points so that the initial configuration can violate the constraint slightly. This helps when saving and loading a game. 
WARNING: 
Do not use a zero or short length.";

%feature("docstring") b2DistanceJointDef::Initialize "Initialize the bodies, anchors, and length using the world anchors.";

%feature("docstring") b2DistanceJointDef::Initialize "Initialize the bodies, anchors, and length using the world anchors.";


// File: structb2_distance_output.xml
%feature("docstring") b2DistanceOutput "Output for b2Distance.";


// File: structb2_distance_proxy.xml
%feature("docstring") b2DistanceProxy "A distance proxy is used by the GJK algorithm. It encapsulates any shape.";

%feature("docstring") b2DistanceProxy::Set "Initialize the proxy using the given shape. The shape must remain in scope while the proxy is in use.";

%feature("docstring") b2DistanceProxy::GetSupport "Get the supporting vertex index in the given direction.";

%feature("docstring") b2DistanceProxy::GetSupportVertex "Get the supporting vertex in the given direction.";

%feature("docstring") b2DistanceProxy::GetVertexCount "Get the vertex count.";

%feature("docstring") b2DistanceProxy::GetVertex "Get a vertex by index. Used by b2Distance.";

%feature("docstring") b2DistanceProxy::Set "Initialize the proxy using the given shape. The shape must remain in scope while the proxy is in use.";

%feature("docstring") b2DistanceProxy::GetSupport "Get the supporting vertex index in the given direction.";

%feature("docstring") b2DistanceProxy::GetSupportVertex "Get the supporting vertex in the given direction.";

%feature("docstring") b2DistanceProxy::GetVertexCount "Get the vertex count.";

%feature("docstring") b2DistanceProxy::GetVertex "Get a vertex by index. Used by b2Distance.";


// File: classb2_draw.xml
%feature("docstring") b2Draw "Implement and register this class with a  b2Worldto provide debug drawing of physics entities in your game.";

%feature("docstring") b2Draw::SetFlags "Set the drawing flags.";

%feature("docstring") b2Draw::GetFlags "Get the drawing flags.";

%feature("docstring") b2Draw::AppendFlags "Append flags to the current flags.";

%feature("docstring") b2Draw::ClearFlags "Clear flags from the current flags.";

%feature("docstring") b2Draw::DrawPolygon "Draw a closed polygon provided in CCW order.";

%feature("docstring") b2Draw::DrawSolidPolygon "Draw a solid closed polygon provided in CCW order.";

%feature("docstring") b2Draw::DrawCircle "Draw a circle.";

%feature("docstring") b2Draw::DrawSolidCircle "Draw a solid circle.";

%feature("docstring") b2Draw::DrawSegment "Draw a line segment.";

%feature("docstring") b2Draw::DrawTransform "Draw a transform. Choose your own length scale.

Parameters:
-----------

xf: 
a transform.";

%feature("docstring") b2Draw::SetFlags "Set the drawing flags.";

%feature("docstring") b2Draw::GetFlags "Get the drawing flags.";

%feature("docstring") b2Draw::AppendFlags "Append flags to the current flags.";

%feature("docstring") b2Draw::ClearFlags "Clear flags from the current flags.";

%feature("docstring") b2Draw::DrawPolygon "Draw a closed polygon provided in CCW order.";

%feature("docstring") b2Draw::DrawSolidPolygon "Draw a solid closed polygon provided in CCW order.";

%feature("docstring") b2Draw::DrawCircle "Draw a circle.";

%feature("docstring") b2Draw::DrawSolidCircle "Draw a solid circle.";

%feature("docstring") b2Draw::DrawSegment "Draw a line segment.";

%feature("docstring") b2Draw::DrawTransform "Draw a transform. Choose your own length scale.

Parameters:
-----------

xf: 
a transform.";


// File: classb2_dynamic_tree.xml
%feature("docstring") b2DynamicTree "A dynamic tree arranges data in a binary tree to accelerate queries such as volume queries and ray casts. Leafs are proxies with an AABB. In the tree we expand the proxy AABB by b2_fatAABBFactor so that the proxy AABB is bigger than the client object. This allows the client object to move by small amounts without triggering a tree update.
Nodes are pooled and relocatable, so we use node indices rather than pointers.";

%feature("docstring") b2DynamicTree::b2DynamicTree "Constructing the tree initializes the node pool.";

%feature("docstring") b2DynamicTree::~b2DynamicTree "Destroy the tree, freeing the node pool.";

%feature("docstring") b2DynamicTree::CreateProxy "Create a proxy. Provide a tight fitting AABB and a userData pointer.";

%feature("docstring") b2DynamicTree::DestroyProxy "Destroy a proxy. This asserts if the id is invalid.";

%feature("docstring") b2DynamicTree::MoveProxy "Move a proxy with a swepted AABB. If the proxy has moved outside of its fattened AABB, then the proxy is removed from the tree and re-inserted. Otherwise the function returns immediately. 
true if the proxy was re-inserted.";

%feature("docstring") b2DynamicTree::Rebalance "Perform some iterations to re-balance the tree.";

%feature("docstring") b2DynamicTree::GetUserData "Get proxy user data. 
the proxy user data or 0 if the id is invalid.";

%feature("docstring") b2DynamicTree::GetFatAABB "Get the fat AABB for a proxy.";

%feature("docstring") b2DynamicTree::ComputeHeight "Compute the height of the binary tree in O(N) time. Should not be called often.";

%feature("docstring") b2DynamicTree::Query "Query an AABB for overlapping proxies. The callback class is called for each proxy that overlaps the supplied AABB.";

%feature("docstring") b2DynamicTree::RayCast "Ray-cast against the proxies in the tree. This relies on the callback to perform a exact ray-cast in the case were the proxy contains a shape. The callback also performs the any collision filtering. This has performance roughly equal to k * log(n), where k is the number of collisions and n is the number of proxies in the tree.

Parameters:
-----------

input: 
the ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).

callback: 
a callback class that is called for each proxy that is hit by the ray.";

%feature("docstring") b2DynamicTree::b2DynamicTree "Constructing the tree initializes the node pool.";

%feature("docstring") b2DynamicTree::~b2DynamicTree "Destroy the tree, freeing the node pool.";

%feature("docstring") b2DynamicTree::CreateProxy "Create a proxy. Provide a tight fitting AABB and a userData pointer.";

%feature("docstring") b2DynamicTree::DestroyProxy "Destroy a proxy. This asserts if the id is invalid.";

%feature("docstring") b2DynamicTree::MoveProxy "Move a proxy with a swepted AABB. If the proxy has moved outside of its fattened AABB, then the proxy is removed from the tree and re-inserted. Otherwise the function returns immediately. 
true if the proxy was re-inserted.";

%feature("docstring") b2DynamicTree::Rebalance "Perform some iterations to re-balance the tree.";

%feature("docstring") b2DynamicTree::GetUserData "Get proxy user data. 
the proxy user data or 0 if the id is invalid.";

%feature("docstring") b2DynamicTree::GetFatAABB "Get the fat AABB for a proxy.";

%feature("docstring") b2DynamicTree::ComputeHeight "Compute the height of the binary tree in O(N) time. Should not be called often.";

%feature("docstring") b2DynamicTree::Query "Query an AABB for overlapping proxies. The callback class is called for each proxy that overlaps the supplied AABB.";

%feature("docstring") b2DynamicTree::RayCast "Ray-cast against the proxies in the tree. This relies on the callback to perform a exact ray-cast in the case were the proxy contains a shape. The callback also performs the any collision filtering. This has performance roughly equal to k * log(n), where k is the number of collisions and n is the number of proxies in the tree.

Parameters:
-----------

input: 
the ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).

callback: 
a callback class that is called for each proxy that is hit by the ray.";


// File: structb2_dynamic_tree_node.xml
%feature("docstring") b2DynamicTreeNode "A node in the dynamic tree. The client does not interact with this directly. 
A dynamic AABB tree broad-phase, inspired by Nathanael Presson's btDbvt.";


// File: classb2_edge_shape.xml
%feature("docstring") b2EdgeShape "A line segment (edge) shape. These can be connected in chains or loops to other edge shapes. The connectivity information is used to ensure correct contact normals.";

%feature("docstring") b2EdgeShape::Set "Set this as an isolated edge.";

%feature("docstring") b2EdgeShape::Clone "Implement  b2Shape.";

%feature("docstring") b2EdgeShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2EdgeShape::TestPoint "

See: 
 b2Shape::TestPoint";

%feature("docstring") b2EdgeShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2EdgeShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2EdgeShape::ComputeMass "

See: 
 b2Shape::ComputeMass";

%feature("docstring") b2EdgeShape::Set "Set this as an isolated edge.";

%feature("docstring") b2EdgeShape::Clone "Implement  b2Shape.";

%feature("docstring") b2EdgeShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2EdgeShape::TestPoint "

See: 
 b2Shape::TestPoint";

%feature("docstring") b2EdgeShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2EdgeShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2EdgeShape::ComputeMass "

See: 
 b2Shape::ComputeMass";


// File: structb2_filter.xml
%feature("docstring") b2Filter "This holds contact filtering data.";


// File: classb2_fixture.xml
%feature("docstring") b2Fixture "A fixture is used to attach a shape to a body for collision detection. A fixture inherits its transform from its parent. Fixtures hold additional non-geometric data such as friction, collision filters, etc. Fixtures are created via  b2Body::CreateFixture. 
WARNING: 
you cannot reuse fixtures.";

%feature("docstring") b2Fixture::GetType "Get the type of the child shape. You can use this to down cast to the concrete shape. 
the shape type.";

%feature("docstring") b2Fixture::GetShape "Get the child shape. You can modify the child shape, however you should not change the number of vertices because this will crash some collision caching mechanisms. Manipulating the shape may lead to non-physical behavior.";

%feature("docstring") b2Fixture::SetSensor "Set if this fixture is a sensor.";

%feature("docstring") b2Fixture::IsSensor "Is this fixture a sensor (non-solid)? 
the true if the shape is a sensor.";

%feature("docstring") b2Fixture::SetFilterData "Set the contact filtering data. This will not update contacts until the next time step when either parent body is active and awake. This automatically calls Refilter.";

%feature("docstring") b2Fixture::GetFilterData "Get the contact filtering data.";

%feature("docstring") b2Fixture::Refilter "Call this if you want to establish collision that was previously disabled by  b2ContactFilter::ShouldCollide.";

%feature("docstring") b2Fixture::GetBody "Get the parent body of this fixture. This is NULL if the fixture is not attached. 
the parent body.";

%feature("docstring") b2Fixture::GetNext "Get the next fixture in the parent body's fixture list. 
the next shape.";

%feature("docstring") b2Fixture::GetUserData "Get the user data that was assigned in the fixture definition. Use this to store your application specific data.";

%feature("docstring") b2Fixture::SetUserData "Set the user data. Use this to store your application specific data.";

%feature("docstring") b2Fixture::TestPoint "Test a point for containment in this fixture.

Parameters:
-----------

p: 
a point in world coordinates.";

%feature("docstring") b2Fixture::RayCast "Cast a ray against this shape.

Parameters:
-----------

output: 
the ray-cast results.

input: 
the ray-cast input parameters.";

%feature("docstring") b2Fixture::GetMassData "Get the mass data for this fixture. The mass data is based on the density and the shape. The rotational inertia is about the shape's origin. This operation may be expensive.";

%feature("docstring") b2Fixture::SetDensity "Set the density of this fixture. This will _not_ automatically adjust the mass of the body. You must call  b2Body::ResetMassDatato update the body's mass.";

%feature("docstring") b2Fixture::GetDensity "Get the density of this fixture.";

%feature("docstring") b2Fixture::GetFriction "Get the coefficient of friction.";

%feature("docstring") b2Fixture::SetFriction "Set the coefficient of friction. This will immediately update the mixed friction on all associated contacts.";

%feature("docstring") b2Fixture::GetRestitution "Get the coefficient of restitution.";

%feature("docstring") b2Fixture::SetRestitution "Set the coefficient of restitution. This will immediately update the mixed restitution on all associated contacts.";

%feature("docstring") b2Fixture::GetAABB "Get the fixture's AABB. This AABB may be enlarge and/or stale. If you need a more accurate AABB, compute it using the shape and the body transform.";

%feature("docstring") b2Fixture::GetType "Get the type of the child shape. You can use this to down cast to the concrete shape. 
the shape type.";

%feature("docstring") b2Fixture::GetShape "Get the child shape. You can modify the child shape, however you should not change the number of vertices because this will crash some collision caching mechanisms. Manipulating the shape may lead to non-physical behavior.";

%feature("docstring") b2Fixture::SetSensor "Set if this fixture is a sensor.";

%feature("docstring") b2Fixture::IsSensor "Is this fixture a sensor (non-solid)? 
the true if the shape is a sensor.";

%feature("docstring") b2Fixture::SetFilterData "Set the contact filtering data. This will not update contacts until the next time step when either parent body is active and awake. This automatically calls Refilter.";

%feature("docstring") b2Fixture::GetFilterData "Get the contact filtering data.";

%feature("docstring") b2Fixture::Refilter "Call this if you want to establish collision that was previously disabled by  b2ContactFilter::ShouldCollide.";

%feature("docstring") b2Fixture::GetBody "Get the parent body of this fixture. This is NULL if the fixture is not attached. 
the parent body.";

%feature("docstring") b2Fixture::GetNext "Get the next fixture in the parent body's fixture list. 
the next shape.";

%feature("docstring") b2Fixture::GetUserData "Get the user data that was assigned in the fixture definition. Use this to store your application specific data.";

%feature("docstring") b2Fixture::SetUserData "Set the user data. Use this to store your application specific data.";

%feature("docstring") b2Fixture::TestPoint "Test a point for containment in this fixture.

Parameters:
-----------

p: 
a point in world coordinates.";

%feature("docstring") b2Fixture::RayCast "Cast a ray against this shape.

Parameters:
-----------

output: 
the ray-cast results.

input: 
the ray-cast input parameters.";

%feature("docstring") b2Fixture::GetMassData "Get the mass data for this fixture. The mass data is based on the density and the shape. The rotational inertia is about the shape's origin. This operation may be expensive.";

%feature("docstring") b2Fixture::SetDensity "Set the density of this fixture. This will _not_ automatically adjust the mass of the body. You must call  b2Body::ResetMassDatato update the body's mass.";

%feature("docstring") b2Fixture::GetDensity "Get the density of this fixture.";

%feature("docstring") b2Fixture::GetFriction "Get the coefficient of friction.";

%feature("docstring") b2Fixture::SetFriction "Set the coefficient of friction. This will immediately update the mixed friction on all associated contacts.";

%feature("docstring") b2Fixture::GetRestitution "Get the coefficient of restitution.";

%feature("docstring") b2Fixture::SetRestitution "Set the coefficient of restitution. This will immediately update the mixed restitution on all associated contacts.";

%feature("docstring") b2Fixture::GetAABB "Get the fixture's AABB. This AABB may be enlarge and/or stale. If you need a more accurate AABB, compute it using the shape and the body transform.";


// File: structb2_fixture_def.xml
%feature("docstring") b2FixtureDef "A fixture definition is used to create a fixture. This class defines an abstract fixture definition. You can reuse fixture definitions safely.";

%feature("docstring") b2FixtureDef::b2FixtureDef "The constructor sets the default fixture definition values.";

%feature("docstring") b2FixtureDef::b2FixtureDef "The constructor sets the default fixture definition values.";


// File: structb2_fixture_proxy.xml
%feature("docstring") b2FixtureProxy "This proxy is used internally to connect fixtures to the broad-phase.";


// File: classb2_friction_joint.xml
%feature("docstring") b2FrictionJoint "Friction joint. This is used for top-down friction. It provides 2D translational friction and angular friction.";

%feature("docstring") b2FrictionJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2FrictionJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2FrictionJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2FrictionJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2FrictionJoint::SetMaxForce "Set the maximum friction force in N.";

%feature("docstring") b2FrictionJoint::GetMaxForce "Get the maximum friction force in N.";

%feature("docstring") b2FrictionJoint::SetMaxTorque "Set the maximum friction torque in N*m.";

%feature("docstring") b2FrictionJoint::GetMaxTorque "Get the maximum friction torque in N*m.";

%feature("docstring") b2FrictionJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2FrictionJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2FrictionJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2FrictionJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2FrictionJoint::SetMaxForce "Set the maximum friction force in N.";

%feature("docstring") b2FrictionJoint::GetMaxForce "Get the maximum friction force in N.";

%feature("docstring") b2FrictionJoint::SetMaxTorque "Set the maximum friction torque in N*m.";

%feature("docstring") b2FrictionJoint::GetMaxTorque "Get the maximum friction torque in N*m.";


// File: structb2_friction_joint_def.xml
%feature("docstring") b2FrictionJointDef "Friction joint definition.";

%feature("docstring") b2FrictionJointDef::Initialize "Initialize the bodies, anchors, axis, and reference angle using the world anchor and world axis.";

%feature("docstring") b2FrictionJointDef::Initialize "Initialize the bodies, anchors, axis, and reference angle using the world anchor and world axis.";


// File: classb2_gear_joint.xml
%feature("docstring") b2GearJoint "A gear joint is used to connect two joints together. Either joint can be a revolute or prismatic joint. You specify a gear ratio to bind the motions together: coordinate1 + ratio * coordinate2 = constant The ratio can be negative or positive. If one joint is a revolute joint and the other joint is a prismatic joint, then the ratio will have units of length or units of 1/length. 
WARNING: 
The revolute and prismatic joints must be attached to fixed bodies (which must be body1 on those joints).";

%feature("docstring") b2GearJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2GearJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2GearJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2GearJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2GearJoint::SetRatio "Set/Get the gear ratio.";

%feature("docstring") b2GearJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2GearJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2GearJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2GearJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2GearJoint::SetRatio "Set/Get the gear ratio.";


// File: structb2_gear_joint_def.xml
%feature("docstring") b2GearJointDef "Gear joint definition. This definition requires two existing revolute or prismatic joints (any combination will work). The provided joints must attach a dynamic body to a static body.";


// File: classb2_growable_stack.xml
%feature("docstring") b2GrowableStack "This is a growable LIFO stack with an initial capacity of N. If the stack size exceeds the initial capacity, the heap is used to increase the size of the stack.";


// File: classb2_island.xml
%feature("docstring") b2Island "This is an internal class.";


// File: classb2_joint.xml
%feature("docstring") b2Joint "The base joint class. Joints are used to constraint two bodies together in various fashions. Some joints also feature limits and motors.";

%feature("docstring") b2Joint::GetType "Get the type of the concrete joint.";

%feature("docstring") b2Joint::GetBodyA "Get the first body attached to this joint.";

%feature("docstring") b2Joint::GetBodyB "Get the second body attached to this joint.";

%feature("docstring") b2Joint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2Joint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2Joint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2Joint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2Joint::GetNext "Get the next joint the world joint list.";

%feature("docstring") b2Joint::GetUserData "Get the user data pointer.";

%feature("docstring") b2Joint::SetUserData "Set the user data pointer.";

%feature("docstring") b2Joint::IsActive "Short-cut function to determine if either body is inactive.";

%feature("docstring") b2Joint::GetType "Get the type of the concrete joint.";

%feature("docstring") b2Joint::GetBodyA "Get the first body attached to this joint.";

%feature("docstring") b2Joint::GetBodyB "Get the second body attached to this joint.";

%feature("docstring") b2Joint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2Joint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2Joint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2Joint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2Joint::GetNext "Get the next joint the world joint list.";

%feature("docstring") b2Joint::GetUserData "Get the user data pointer.";

%feature("docstring") b2Joint::SetUserData "Set the user data pointer.";

%feature("docstring") b2Joint::IsActive "Short-cut function to determine if either body is inactive.";


// File: structb2_joint_def.xml
%feature("docstring") b2JointDef "Joint definitions are used to construct joints.";


// File: structb2_joint_edge.xml
%feature("docstring") b2JointEdge "A joint edge is used to connect bodies and joints together in a joint graph where each body is a node and each joint is an edge. A joint edge belongs to a doubly linked list maintained in each attached body. Each joint has two joint nodes, one for each attached body.";


// File: classb2_line_joint.xml
%feature("docstring") b2WheelJoint "A line joint. This joint provides two degrees of freedom: translation along an axis fixed in body1 and rotation in the plane. You can use a joint limit to restrict the range of motion and a joint motor to drive the rotation or to model rotational friction. This joint is designed for vehicle suspensions.";

%feature("docstring") b2WheelJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2WheelJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2WheelJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2WheelJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2WheelJoint::GetJointTranslation "Get the current joint translation, usually in meters.";

%feature("docstring") b2WheelJoint::GetJointSpeed "Get the current joint translation speed, usually in meters per second.";

%feature("docstring") b2WheelJoint::IsMotorEnabled "Is the joint motor enabled?";

%feature("docstring") b2WheelJoint::EnableMotor "Enable/disable the joint motor.";

%feature("docstring") b2WheelJoint::SetMotorSpeed "Set the motor speed, usually in radians per second.";

%feature("docstring") b2WheelJoint::GetMotorSpeed "Get the motor speed, usually in radians per second.";

%feature("docstring") b2WheelJoint::SetMaxMotorTorque "Set/Get the maximum motor force, usually in N-m.";

%feature("docstring") b2WheelJoint::GetMotorTorque "Get the current motor torque given the inverse time step, usually in N-m.";

%feature("docstring") b2WheelJoint::SetSpringFrequencyHz "Set/Get the spring frequency in hertz. Setting the frequency to zero disables the spring.";

%feature("docstring") b2WheelJoint::SetSpringDampingRatio "Set/Get the spring damping ratio.";

%feature("docstring") b2WheelJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2WheelJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2WheelJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2WheelJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2WheelJoint::GetJointTranslation "Get the current joint translation, usually in meters.";

%feature("docstring") b2WheelJoint::GetJointSpeed "Get the current joint translation speed, usually in meters per second.";

%feature("docstring") b2WheelJoint::IsMotorEnabled "Is the joint motor enabled?";

%feature("docstring") b2WheelJoint::EnableMotor "Enable/disable the joint motor.";

%feature("docstring") b2WheelJoint::SetMotorSpeed "Set the motor speed, usually in radians per second.";

%feature("docstring") b2WheelJoint::GetMotorSpeed "Get the motor speed, usually in radians per second.";

%feature("docstring") b2WheelJoint::SetMaxMotorTorque "Set/Get the maximum motor force, usually in N-m.";

%feature("docstring") b2WheelJoint::GetMotorTorque "Get the current motor torque given the inverse time step, usually in N-m.";

%feature("docstring") b2WheelJoint::SetSpringFrequencyHz "Set/Get the spring frequency in hertz. Setting the frequency to zero disables the spring.";

%feature("docstring") b2WheelJoint::SetSpringDampingRatio "Set/Get the spring damping ratio.";


// File: structb2_line_joint_def.xml
%feature("docstring") b2WheelJointDef "Line joint definition. This requires defining a line of motion using an axis and an anchor point. The definition uses local anchor points and a local axis so that the initial configuration can violate the constraint slightly. The joint translation is zero when the local anchor points coincide in world space. Using local anchors and a local axis helps when saving and loading a game.";

%feature("docstring") b2WheelJointDef::Initialize "Initialize the bodies, anchors, axis, and reference angle using the world anchor and world axis.";

%feature("docstring") b2WheelJointDef::Initialize "Initialize the bodies, anchors, axis, and reference angle using the world anchor and world axis.";


// File: classb2_loop_shape.xml
%feature("docstring") b2LoopShape "A loop shape is a free form sequence of line segments that form a circular list. The loop may cross upon itself, but this is not recommended for smooth collision. The loop has double sided collision, so you can use inside and outside collision. Therefore, you may use any winding order. Since there may be many vertices, they are allocated using b2Alloc.";

%feature("docstring") b2LoopShape::~b2LoopShape "The destructor frees the vertices using b2Free.";

%feature("docstring") b2LoopShape::Create "Create the loop shape, copy all vertices.";

%feature("docstring") b2LoopShape::Clone "Implement  b2Shape. Vertices are cloned using b2Alloc.";

%feature("docstring") b2LoopShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2LoopShape::GetChildEdge "Get a child edge.";

%feature("docstring") b2LoopShape::TestPoint "This always return false. 
See: 
 b2Shape::TestPoint";

%feature("docstring") b2LoopShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2LoopShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2LoopShape::ComputeMass "Chains have zero mass. 
See: 
 b2Shape::ComputeMass";

%feature("docstring") b2LoopShape::GetCount "Get the number of vertices.";

%feature("docstring") b2LoopShape::GetVertex "Get the vertices (read-only).";

%feature("docstring") b2LoopShape::GetVertices "Get the vertices (read-only).";

%feature("docstring") b2LoopShape::~b2LoopShape "The destructor frees the vertices using b2Free.";

%feature("docstring") b2LoopShape::Create "Create the loop shape, copy all vertices.";

%feature("docstring") b2LoopShape::Clone "Implement  b2Shape. Vertices are cloned using b2Alloc.";

%feature("docstring") b2LoopShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2LoopShape::GetChildEdge "Get a child edge.";

%feature("docstring") b2LoopShape::TestPoint "This always return false. 
See: 
 b2Shape::TestPoint";

%feature("docstring") b2LoopShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2LoopShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2LoopShape::ComputeMass "Chains have zero mass. 
See: 
 b2Shape::ComputeMass";

%feature("docstring") b2LoopShape::GetCount "Get the number of vertices.";

%feature("docstring") b2LoopShape::GetVertex "Get the vertices (read-only).";

%feature("docstring") b2LoopShape::GetVertices "Get the vertices (read-only).";


// File: structb2_manifold.xml
%feature("docstring") b2Manifold "A manifold for two touching convex shapes. Box2D supports multiple types of contact:
clip point versus plane with radius
point versus point with radius (circles) The local point usage depends on the manifold type: -e_circles: the local center of circleA -e_faceA: the center of faceA -e_faceB: the center of faceB Similarly the local normal usage: -e_circles: not used -e_faceA: the normal on polygonA -e_faceB: the normal on polygonB We store contacts in this way so that position correction can account for movement, which is critical for continuous physics. All contact scenarios must be expressed in one of these types. This structure is stored across time steps, so we keep it small.";


// File: structb2_manifold_point.xml
%feature("docstring") b2ManifoldPoint "A manifold point is a contact point belonging to a contact manifold. It holds details related to the geometry and dynamics of the contact points. The local point usage depends on the manifold type: -e_circles: the local center of circleB -e_faceA: the local center of cirlceB or the clip point of polygonB -e_faceB: the clip point of polygonA This structure is stored across time steps, so we keep it small. Note: the impulses are used for internal caching and may not provide reliable contact forces, especially for high speed collisions.";


// File: structb2_mass_data.xml
%feature("docstring") b2MassData "This holds the mass data computed for a shape.";


// File: structb2_mat22.xml
%feature("docstring") b2Mat22 "A 2-by-2 matrix. Stored in column-major order.";

%feature("docstring") b2Mat22::b2Mat22 "The default constructor does nothing (for performance).";

%feature("docstring") b2Mat22::b2Mat22 "Construct this matrix using columns.";

%feature("docstring") b2Mat22::b2Mat22 "Construct this matrix using scalars.";

%feature("docstring") b2Mat22::b2Mat22 "Construct this matrix using an angle. This matrix becomes an orthonormal rotation matrix.";

%feature("docstring") b2Mat22::Set "Initialize this matrix using columns.";

%feature("docstring") b2Mat22::Set "Initialize this matrix using an angle. This matrix becomes an orthonormal rotation matrix.";

%feature("docstring") b2Mat22::SetIdentity "Set this to the identity matrix.";

%feature("docstring") b2Mat22::SetZero "Set this matrix to all zeros.";

%feature("docstring") b2Mat22::GetAngle "Extract the angle from this matrix (assumed to be a rotation matrix).";

%feature("docstring") b2Mat22::Solve "Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases.";

%feature("docstring") b2Mat22::b2Mat22 "The default constructor does nothing (for performance).";

%feature("docstring") b2Mat22::b2Mat22 "Construct this matrix using columns.";

%feature("docstring") b2Mat22::b2Mat22 "Construct this matrix using scalars.";

%feature("docstring") b2Mat22::b2Mat22 "Construct this matrix using an angle. This matrix becomes an orthonormal rotation matrix.";

%feature("docstring") b2Mat22::Set "Initialize this matrix using columns.";

%feature("docstring") b2Mat22::Set "Initialize this matrix using an angle. This matrix becomes an orthonormal rotation matrix.";

%feature("docstring") b2Mat22::SetIdentity "Set this to the identity matrix.";

%feature("docstring") b2Mat22::SetZero "Set this matrix to all zeros.";

%feature("docstring") b2Mat22::GetAngle "Extract the angle from this matrix (assumed to be a rotation matrix).";

%feature("docstring") b2Mat22::Solve "Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases.";


// File: structb2_mat33.xml
%feature("docstring") b2Mat33 "A 3-by-3 matrix. Stored in column-major order.";

%feature("docstring") b2Mat33::b2Mat33 "The default constructor does nothing (for performance).";

%feature("docstring") b2Mat33::b2Mat33 "Construct this matrix using columns.";

%feature("docstring") b2Mat33::SetZero "Set this matrix to all zeros.";

%feature("docstring") b2Mat33::Solve33 "Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases.";

%feature("docstring") b2Mat33::Solve22 "Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases. Solve only the upper 2-by-2 matrix equation.
Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases.";

%feature("docstring") b2Mat33::b2Mat33 "The default constructor does nothing (for performance).";

%feature("docstring") b2Mat33::b2Mat33 "Construct this matrix using columns.";

%feature("docstring") b2Mat33::SetZero "Set this matrix to all zeros.";

%feature("docstring") b2Mat33::Solve33 "Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases.";

%feature("docstring") b2Mat33::Solve22 "Solve A * x = b, where b is a column vector. This is more efficient than computing the inverse in one-shot cases. Solve only the upper 2-by-2 matrix equation.";


// File: classb2_mouse_joint.xml
%feature("docstring") b2MouseJoint "A mouse joint is used to make a point on a body track a specified world point. This a soft constraint with a maximum force. This allows the constraint to stretch and without applying huge forces. NOTE: this joint is not documented in the manual because it was developed to be used in the testbed. If you want to learn how to use the mouse joint, look at the testbed.";

%feature("docstring") b2MouseJoint::GetAnchorA "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::GetAnchorB "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::GetReactionForce "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::GetReactionTorque "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::SetTarget "Use this to update the target point.";

%feature("docstring") b2MouseJoint::SetMaxForce "Set/get the maximum force in Newtons.";

%feature("docstring") b2MouseJoint::SetFrequency "Set/get the frequency in Hertz.";

%feature("docstring") b2MouseJoint::SetDampingRatio "Set/get the damping ratio (dimensionless).";

%feature("docstring") b2MouseJoint::GetAnchorA "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::GetAnchorB "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::GetReactionForce "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::GetReactionTorque "Implements  b2Joint.";

%feature("docstring") b2MouseJoint::SetTarget "Use this to update the target point.";

%feature("docstring") b2MouseJoint::SetMaxForce "Set/get the maximum force in Newtons.";

%feature("docstring") b2MouseJoint::SetFrequency "Set/get the frequency in Hertz.";

%feature("docstring") b2MouseJoint::SetDampingRatio "Set/get the damping ratio (dimensionless).";


// File: structb2_mouse_joint_def.xml
%feature("docstring") b2MouseJointDef "Mouse joint definition. This requires a world target point, tuning parameters, and the time step.";


// File: classb2_polygon_shape.xml
%feature("docstring") b2PolygonShape "A convex polygon. It is assumed that the interior of the polygon is to the left of each edge. Polygons have a maximum number of vertices equal to b2_maxPolygonVertices. In most cases you should not need many vertices for a convex polygon.";

%feature("docstring") b2PolygonShape::Clone "Implement  b2Shape.";

%feature("docstring") b2PolygonShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2PolygonShape::Set "Copy vertices. This assumes the vertices define a convex polygon. It is assumed that the exterior is the the right of each edge. The count must be in the range [3, b2_maxPolygonVertices].";

%feature("docstring") b2PolygonShape::SetAsBox "Build vertices to represent an axis-aligned box.

Parameters:
-----------

hx: 
the half-width.

hy: 
the half-height.";

%feature("docstring") b2PolygonShape::SetAsBox "Build vertices to represent an oriented box.

Parameters:
-----------

hx: 
the half-width.

hy: 
the half-height.

center: 
the center of the box in local coordinates.

angle: 
the rotation of the box in local coordinates.";

%feature("docstring") b2PolygonShape::TestPoint "

See: 
 b2Shape::TestPoint";

%feature("docstring") b2PolygonShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2PolygonShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2PolygonShape::ComputeMass "

See: 
 b2Shape::ComputeMass";

%feature("docstring") b2PolygonShape::GetVertexCount "Get the vertex count.";

%feature("docstring") b2PolygonShape::GetVertex "Get a vertex by index.";

%feature("docstring") b2PolygonShape::Clone "Implement  b2Shape.";

%feature("docstring") b2PolygonShape::GetChildCount "

See: 
 b2Shape::GetChildCount";

%feature("docstring") b2PolygonShape::Set "Copy vertices. This assumes the vertices define a convex polygon. It is assumed that the exterior is the the right of each edge. The count must be in the range [3, b2_maxPolygonVertices].";

%feature("docstring") b2PolygonShape::SetAsBox "Build vertices to represent an axis-aligned box.

Parameters:
-----------

hx: 
the half-width.

hy: 
the half-height.";

%feature("docstring") b2PolygonShape::SetAsBox "Build vertices to represent an oriented box.

Parameters:
-----------

hx: 
the half-width.

hy: 
the half-height.

center: 
the center of the box in local coordinates.

angle: 
the rotation of the box in local coordinates.";

%feature("docstring") b2PolygonShape::TestPoint "

See: 
 b2Shape::TestPoint";

%feature("docstring") b2PolygonShape::RayCast "Implement  b2Shape.";

%feature("docstring") b2PolygonShape::ComputeAABB "

See: 
 b2Shape::ComputeAABB";

%feature("docstring") b2PolygonShape::ComputeMass "

See: 
 b2Shape::ComputeMass";

%feature("docstring") b2PolygonShape::GetVertexCount "Get the vertex count.";

%feature("docstring") b2PolygonShape::GetVertex "Get a vertex by index.";


// File: structb2_position.xml
%feature("docstring") b2Position "This is an internal structure.";


// File: classb2_prismatic_joint.xml
%feature("docstring") b2PrismaticJoint "A prismatic joint. This joint provides one degree of freedom: translation along an axis fixed in body1. Relative rotation is prevented. You can use a joint limit to restrict the range of motion and a joint motor to drive the motion or to model joint friction.";

%feature("docstring") b2PrismaticJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2PrismaticJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2PrismaticJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2PrismaticJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2PrismaticJoint::GetJointTranslation "Get the current joint translation, usually in meters.";

%feature("docstring") b2PrismaticJoint::GetJointSpeed "Get the current joint translation speed, usually in meters per second.";

%feature("docstring") b2PrismaticJoint::IsLimitEnabled "Is the joint limit enabled?";

%feature("docstring") b2PrismaticJoint::EnableLimit "Enable/disable the joint limit.";

%feature("docstring") b2PrismaticJoint::GetLowerLimit "Get the lower joint limit, usually in meters.";

%feature("docstring") b2PrismaticJoint::GetUpperLimit "Get the upper joint limit, usually in meters.";

%feature("docstring") b2PrismaticJoint::SetLimits "Set the joint limits, usually in meters.";

%feature("docstring") b2PrismaticJoint::IsMotorEnabled "Is the joint motor enabled?";

%feature("docstring") b2PrismaticJoint::EnableMotor "Enable/disable the joint motor.";

%feature("docstring") b2PrismaticJoint::SetMotorSpeed "Set the motor speed, usually in meters per second.";

%feature("docstring") b2PrismaticJoint::GetMotorSpeed "Get the motor speed, usually in meters per second.";

%feature("docstring") b2PrismaticJoint::SetMaxMotorForce "Set the maximum motor force, usually in N.";

%feature("docstring") b2PrismaticJoint::GetMotorForce "Get the current motor force given the inverse time step, usually in N.";

%feature("docstring") b2PrismaticJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2PrismaticJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2PrismaticJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2PrismaticJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2PrismaticJoint::GetJointTranslation "Get the current joint translation, usually in meters.";

%feature("docstring") b2PrismaticJoint::GetJointSpeed "Get the current joint translation speed, usually in meters per second.";

%feature("docstring") b2PrismaticJoint::IsLimitEnabled "Is the joint limit enabled?";

%feature("docstring") b2PrismaticJoint::EnableLimit "Enable/disable the joint limit.";

%feature("docstring") b2PrismaticJoint::GetLowerLimit "Get the lower joint limit, usually in meters.";

%feature("docstring") b2PrismaticJoint::GetUpperLimit "Get the upper joint limit, usually in meters.";

%feature("docstring") b2PrismaticJoint::SetLimits "Set the joint limits, usually in meters.";

%feature("docstring") b2PrismaticJoint::IsMotorEnabled "Is the joint motor enabled?";

%feature("docstring") b2PrismaticJoint::EnableMotor "Enable/disable the joint motor.";

%feature("docstring") b2PrismaticJoint::SetMotorSpeed "Set the motor speed, usually in meters per second.";

%feature("docstring") b2PrismaticJoint::GetMotorSpeed "Get the motor speed, usually in meters per second.";

%feature("docstring") b2PrismaticJoint::SetMaxMotorForce "Set the maximum motor force, usually in N.";

%feature("docstring") b2PrismaticJoint::GetMotorForce "Get the current motor force given the inverse time step, usually in N.";


// File: structb2_prismatic_joint_def.xml
%feature("docstring") b2PrismaticJointDef "Prismatic joint definition. This requires defining a line of motion using an axis and an anchor point. The definition uses local anchor points and a local axis so that the initial configuration can violate the constraint slightly. The joint translation is zero when the local anchor points coincide in world space. Using local anchors and a local axis helps when saving and loading a game. 
WARNING: 
at least one body should by dynamic with a non-fixed rotation.";

%feature("docstring") b2PrismaticJointDef::Initialize "Initialize the bodies, anchors, axis, and reference angle using the world anchor and world axis.";

%feature("docstring") b2PrismaticJointDef::Initialize "Initialize the bodies, anchors, axis, and reference angle using the world anchor and world axis.";


// File: classb2_pulley_joint.xml
%feature("docstring") b2PulleyJoint "The pulley joint is connected to two bodies and two fixed ground points. The pulley supports a ratio such that: length1 + ratio * length2 <= constant Yes, the force transmitted is scaled by the ratio. The pulley also enforces a maximum length limit on both sides. This is useful to prevent one side of the pulley hitting the top.";

%feature("docstring") b2PulleyJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2PulleyJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2PulleyJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2PulleyJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2PulleyJoint::GetGroundAnchorA "Get the first ground anchor.";

%feature("docstring") b2PulleyJoint::GetGroundAnchorB "Get the second ground anchor.";

%feature("docstring") b2PulleyJoint::GetLength1 "Get the current length of the segment attached to body1.";

%feature("docstring") b2PulleyJoint::GetLength2 "Get the current length of the segment attached to body2.";

%feature("docstring") b2PulleyJoint::GetRatio "Get the pulley ratio.";

%feature("docstring") b2PulleyJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2PulleyJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2PulleyJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2PulleyJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2PulleyJoint::GetGroundAnchorA "Get the first ground anchor.";

%feature("docstring") b2PulleyJoint::GetGroundAnchorB "Get the second ground anchor.";

%feature("docstring") b2PulleyJoint::GetLength1 "Get the current length of the segment attached to body1.";

%feature("docstring") b2PulleyJoint::GetLength2 "Get the current length of the segment attached to body2.";

%feature("docstring") b2PulleyJoint::GetRatio "Get the pulley ratio.";


// File: structb2_pulley_joint_def.xml
%feature("docstring") b2PulleyJointDef "Pulley joint definition. This requires two ground anchors, two dynamic body anchor points, max lengths for each side, and a pulley ratio.";

%feature("docstring") b2PulleyJointDef::Initialize "Initialize the bodies, anchors, lengths, max lengths, and ratio using the world anchors.";

%feature("docstring") b2PulleyJointDef::Initialize "Initialize the bodies, anchors, lengths, max lengths, and ratio using the world anchors.";


// File: classb2_query_callback.xml
%feature("docstring") b2QueryCallback "Callback class for AABB queries. See b2World::Query";

%feature("docstring") b2QueryCallback::ReportFixture "Called for each fixture found in the query AABB. 
false to terminate the query.";

%feature("docstring") b2QueryCallback::ReportFixture "Called for each fixture found in the query AABB. 
false to terminate the query.";


// File: classb2_ray_cast_callback.xml
%feature("docstring") b2RayCastCallback "Callback class for ray casts. See  b2World::RayCast";

%feature("docstring") b2RayCastCallback::ReportFixture "Called for each fixture found in the query. You control how the ray cast proceeds by returning a float: return -1: ignore this fixture and continue return 0: terminate the ray cast return fraction: clip the ray to this point return 1: don't clip the ray and continue

Parameters:
-----------

fixture: 
the fixture hit by the ray

point: 
the point of initial intersection

normal: 
the normal vector at the point of intersection 
-1 to filter, 0 to terminate, fraction to clip the ray for closest hit, 1 to continue";

%feature("docstring") b2RayCastCallback::ReportFixture "Called for each fixture found in the query. You control how the ray cast proceeds by returning a float: return -1: ignore this fixture and continue return 0: terminate the ray cast return fraction: clip the ray to this point return 1: don't clip the ray and continue

Parameters:
-----------

fixture: 
the fixture hit by the ray

point: 
the point of initial intersection

normal: 
the normal vector at the point of intersection 
-1 to filter, 0 to terminate, fraction to clip the ray for closest hit, 1 to continue";


// File: structb2_ray_cast_input.xml
%feature("docstring") b2RayCastInput "Ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).";


// File: structb2_ray_cast_output.xml
%feature("docstring") b2RayCastOutput "Ray-cast output data. The ray hits at p1 + fraction * (p2 - p1), where p1 and p2 come from  b2RayCastInput.";


// File: classb2_revolute_joint.xml
%feature("docstring") b2RevoluteJoint "A revolute joint constrains two bodies to share a common point while they are free to rotate about the point. The relative rotation about the shared point is the joint angle. You can limit the relative rotation with a joint limit that specifies a lower and upper angle. You can use a motor to drive the relative rotation about the shared point. A maximum motor torque is provided so that infinite forces are not generated.";

%feature("docstring") b2RevoluteJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2RevoluteJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2RevoluteJoint::GetJointAngle "Get the current joint angle in radians.";

%feature("docstring") b2RevoluteJoint::GetJointSpeed "Get the current joint angle speed in radians per second.";

%feature("docstring") b2RevoluteJoint::IsLimitEnabled "Is the joint limit enabled?";

%feature("docstring") b2RevoluteJoint::EnableLimit "Enable/disable the joint limit.";

%feature("docstring") b2RevoluteJoint::GetLowerLimit "Get the lower joint limit in radians.";

%feature("docstring") b2RevoluteJoint::GetUpperLimit "Get the upper joint limit in radians.";

%feature("docstring") b2RevoluteJoint::SetLimits "Set the joint limits in radians.";

%feature("docstring") b2RevoluteJoint::IsMotorEnabled "Is the joint motor enabled?";

%feature("docstring") b2RevoluteJoint::EnableMotor "Enable/disable the joint motor.";

%feature("docstring") b2RevoluteJoint::SetMotorSpeed "Set the motor speed in radians per second.";

%feature("docstring") b2RevoluteJoint::GetMotorSpeed "Get the motor speed in radians per second.";

%feature("docstring") b2RevoluteJoint::SetMaxMotorTorque "Set the maximum motor torque, usually in N-m.";

%feature("docstring") b2RevoluteJoint::GetReactionForce "Get the reaction force given the inverse time step. Unit is N.";

%feature("docstring") b2RevoluteJoint::GetReactionTorque "Get the reaction torque due to the joint limit given the inverse time step. Unit is N*m.";

%feature("docstring") b2RevoluteJoint::GetMotorTorque "Get the current motor torque given the inverse time step. Unit is N*m.";

%feature("docstring") b2RevoluteJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2RevoluteJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2RevoluteJoint::GetJointAngle "Get the current joint angle in radians.";

%feature("docstring") b2RevoluteJoint::GetJointSpeed "Get the current joint angle speed in radians per second.";

%feature("docstring") b2RevoluteJoint::IsLimitEnabled "Is the joint limit enabled?";

%feature("docstring") b2RevoluteJoint::EnableLimit "Enable/disable the joint limit.";

%feature("docstring") b2RevoluteJoint::GetLowerLimit "Get the lower joint limit in radians.";

%feature("docstring") b2RevoluteJoint::GetUpperLimit "Get the upper joint limit in radians.";

%feature("docstring") b2RevoluteJoint::SetLimits "Set the joint limits in radians.";

%feature("docstring") b2RevoluteJoint::IsMotorEnabled "Is the joint motor enabled?";

%feature("docstring") b2RevoluteJoint::EnableMotor "Enable/disable the joint motor.";

%feature("docstring") b2RevoluteJoint::SetMotorSpeed "Set the motor speed in radians per second.";

%feature("docstring") b2RevoluteJoint::GetMotorSpeed "Get the motor speed in radians per second.";

%feature("docstring") b2RevoluteJoint::SetMaxMotorTorque "Set the maximum motor torque, usually in N-m.";

%feature("docstring") b2RevoluteJoint::GetReactionForce "Get the reaction force given the inverse time step. Unit is N.";

%feature("docstring") b2RevoluteJoint::GetReactionTorque "Get the reaction torque due to the joint limit given the inverse time step. Unit is N*m.";

%feature("docstring") b2RevoluteJoint::GetMotorTorque "Get the current motor torque given the inverse time step. Unit is N*m.";


// File: structb2_revolute_joint_def.xml
%feature("docstring") b2RevoluteJointDef "Revolute joint definition. This requires defining an anchor point where the bodies are joined. The definition uses local anchor points so that the initial configuration can violate the constraint slightly. You also need to specify the initial relative angle for joint limits. This helps when saving and loading a game. The local anchor points are measured from the body's origin rather than the center of mass because: 1. you might not know where the center of mass will be. 2. if you add/remove shapes from a body and recompute the mass, the joints will be broken.";

%feature("docstring") b2RevoluteJointDef::Initialize "Initialize the bodies, anchors, and reference angle using a world anchor point.";

%feature("docstring") b2RevoluteJointDef::Initialize "Initialize the bodies, anchors, and reference angle using a world anchor point.";


// File: classb2_rope_joint.xml
%feature("docstring") b2RopeJoint "A rope joint enforces a maximum distance between two points on two bodies. It has no other effect. Warning: if you attempt to change the maximum length during the simulation you will get some non-physical behavior. A model that would allow you to dynamically modify the length would have some sponginess, so I chose not to implement it that way. See  b2DistanceJointif you want to dynamically control length.";

%feature("docstring") b2RopeJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2RopeJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2RopeJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2RopeJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2RopeJoint::GetMaxLength "Get the maximum length of the rope.";

%feature("docstring") b2RopeJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2RopeJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2RopeJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2RopeJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2RopeJoint::GetMaxLength "Get the maximum length of the rope.";


// File: structb2_rope_joint_def.xml
%feature("docstring") b2RopeJointDef "Rope joint definition. This requires two body anchor points and a maximum lengths. Note: by default the connected objects will not collide. see collideConnected in  b2JointDef.";


// File: classb2_shape.xml
%feature("docstring") b2Shape "A shape is used for collision detection. You can create a shape however you like. Shapes used for simulation in  b2Worldare created automatically when a  b2Fixtureis created. Shapes may encapsulate a one or more child shapes.";

%feature("docstring") b2Shape::Clone "Clone the concrete shape using the provided allocator.";

%feature("docstring") b2Shape::GetType "Get the type of this shape. You can use this to down cast to the concrete shape. 
the shape type.";

%feature("docstring") b2Shape::GetChildCount "Get the number of child primitives.";

%feature("docstring") b2Shape::TestPoint "Test a point for containment in this shape. This only works for convex shapes.

Parameters:
-----------

xf: 
the shape world transform.

p: 
a point in world coordinates.";

%feature("docstring") b2Shape::RayCast "Cast a ray against a child shape.

Parameters:
-----------

output: 
the ray-cast results.

input: 
the ray-cast input parameters.

transform: 
the transform to be applied to the shape.

childIndex: 
the child shape index";

%feature("docstring") b2Shape::ComputeAABB "Given a transform, compute the associated axis aligned bounding box for a child shape.

Parameters:
-----------

aabb: 
returns the axis aligned box.

xf: 
the world transform of the shape.

childIndex: 
the child shape";

%feature("docstring") b2Shape::ComputeMass "Compute the mass properties of this shape using its dimensions and density. The inertia tensor is computed about the local origin.

Parameters:
-----------

massData: 
returns the mass data for this shape.

density: 
the density in kilograms per meter squared.";

%feature("docstring") b2Shape::Clone "Clone the concrete shape using the provided allocator.";

%feature("docstring") b2Shape::GetType "Get the type of this shape. You can use this to down cast to the concrete shape. 
the shape type.";

%feature("docstring") b2Shape::GetChildCount "Get the number of child primitives.";

%feature("docstring") b2Shape::TestPoint "Test a point for containment in this shape. This only works for convex shapes.

Parameters:
-----------

xf: 
the shape world transform.

p: 
a point in world coordinates.";

%feature("docstring") b2Shape::RayCast "Cast a ray against a child shape.

Parameters:
-----------

output: 
the ray-cast results.

input: 
the ray-cast input parameters.

transform: 
the transform to be applied to the shape.

childIndex: 
the child shape index";

%feature("docstring") b2Shape::ComputeAABB "Given a transform, compute the associated axis aligned bounding box for a child shape.

Parameters:
-----------

aabb: 
returns the axis aligned box.

xf: 
the world transform of the shape.

childIndex: 
the child shape";

%feature("docstring") b2Shape::ComputeMass "Compute the mass properties of this shape using its dimensions and density. The inertia tensor is computed about the local origin.

Parameters:
-----------

massData: 
returns the mass data for this shape.

density: 
the density in kilograms per meter squared.";


// File: structb2_simplex_cache.xml
%feature("docstring") b2SimplexCache "Used to warm start b2Distance. Set count to zero on first call.";


// File: structb2_sweep.xml
%feature("docstring") b2Sweep "This describes the motion of a body/shape for TOI computation. Shapes are defined with respect to the body origin, which may no coincide with the center of mass. However, to support dynamics we must interpolate the center of mass position.";

%feature("docstring") b2Sweep::GetTransform "Get the interpolated transform at a specific time.

Parameters:
-----------

beta: 
is a factor in [0,1], where 0 indicates alpha0.";

%feature("docstring") b2Sweep::Advance "Advance the sweep forward, yielding a new initial state.

Parameters:
-----------

alpha: 
the new initial time.";

%feature("docstring") b2Sweep::Normalize "Normalize the angles. 
Normalize an angle in radians to be between -pi and pi.";

%feature("docstring") b2Sweep::GetTransform "Get the interpolated transform at a specific time.

Parameters:
-----------

beta: 
is a factor in [0,1], where 0 indicates alpha0.";

%feature("docstring") b2Sweep::Advance "Advance the sweep forward, yielding a new initial state.

Parameters:
-----------

alpha: 
the new initial time.";

%feature("docstring") b2Sweep::Normalize "Normalize the angles.";


// File: structb2_time_step.xml
%feature("docstring") b2TimeStep "This is an internal structure.";


// File: structb2_t_o_i_input.xml
%feature("docstring") b2TOIInput "Input parameters for b2TimeOfImpact.";


// File: structb2_transform.xml
%feature("docstring") b2Transform "A transform contains translation and rotation. It is used to represent the position and orientation of rigid frames.";

%feature("docstring") b2Transform::b2Transform "The default constructor does nothing (for performance).";

%feature("docstring") b2Transform::b2Transform "Initialize using a position vector and a rotation matrix.";

%feature("docstring") b2Transform::SetIdentity "Set this to the identity transform.";

%feature("docstring") b2Transform::Set "Set this based on the position and angle.";

%feature("docstring") b2Transform::GetAngle "Calculate the angle that the rotation matrix represents.";

%feature("docstring") b2Transform::b2Transform "The default constructor does nothing (for performance).";

%feature("docstring") b2Transform::b2Transform "Initialize using a position vector and a rotation matrix.";

%feature("docstring") b2Transform::SetIdentity "Set this to the identity transform.";

%feature("docstring") b2Transform::Set "Set this based on the position and angle.";

%feature("docstring") b2Transform::GetAngle "Calculate the angle that the rotation matrix represents.";


// File: structb2_vec2.xml
%feature("docstring") b2Vec2 "A 2D column vector.";

%feature("docstring") b2Vec2::b2Vec2 "Default constructor does nothing (for performance).";

%feature("docstring") b2Vec2::b2Vec2 "Construct using coordinates.";

%feature("docstring") b2Vec2::SetZero "Set this vector to all zeros.";

%feature("docstring") b2Vec2::Set "Set this vector to some specified coordinates.";

%feature("docstring") b2Vec2::Length "Get the length of this vector (the norm).";

%feature("docstring") b2Vec2::LengthSquared "Get the length squared. For performance, use this instead of  b2Vec2::Length(if possible).";

%feature("docstring") b2Vec2::Normalize "Convert this vector into a unit vector. Returns the length.";

%feature("docstring") b2Vec2::IsValid "Does this vector contain finite coordinates?";

%feature("docstring") b2Vec2::Skew "Get the skew vector such that dot(skew_vec, other) == cross(vec, other)";

%feature("docstring") b2Vec2::b2Vec2 "Default constructor does nothing (for performance).";

%feature("docstring") b2Vec2::b2Vec2 "Construct using coordinates.";

%feature("docstring") b2Vec2::SetZero "Set this vector to all zeros.";

%feature("docstring") b2Vec2::Set "Set this vector to some specified coordinates.";

%feature("docstring") b2Vec2::Length "Get the length of this vector (the norm).";

%feature("docstring") b2Vec2::LengthSquared "Get the length squared. For performance, use this instead of  b2Vec2::Length(if possible).";

%feature("docstring") b2Vec2::Normalize "Convert this vector into a unit vector. Returns the length.";

%feature("docstring") b2Vec2::IsValid "Does this vector contain finite coordinates?";

%feature("docstring") b2Vec2::Skew "Get the skew vector such that dot(skew_vec, other) == cross(vec, other)";


// File: structb2_vec3.xml
%feature("docstring") b2Vec3 "A 2D column vector with 3 elements.";

%feature("docstring") b2Vec3::b2Vec3 "Default constructor does nothing (for performance).";

%feature("docstring") b2Vec3::b2Vec3 "Construct using coordinates.";

%feature("docstring") b2Vec3::SetZero "Set this vector to all zeros.";

%feature("docstring") b2Vec3::Set "Set this vector to some specified coordinates.";

%feature("docstring") b2Vec3::b2Vec3 "Default constructor does nothing (for performance).";

%feature("docstring") b2Vec3::b2Vec3 "Construct using coordinates.";

%feature("docstring") b2Vec3::SetZero "Set this vector to all zeros.";

%feature("docstring") b2Vec3::Set "Set this vector to some specified coordinates.";


// File: structb2_velocity.xml
%feature("docstring") b2Velocity "This is an internal structure.";


// File: structb2_version.xml
%feature("docstring") b2Version "Version numbering scheme. See http://en.wikipedia.org/wiki/Software_versioning";


// File: classb2_weld_joint.xml
%feature("docstring") b2WeldJoint "A weld joint essentially glues two bodies together. A weld joint may distort somewhat because the island constraint solver is approximate.";

%feature("docstring") b2WeldJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2WeldJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2WeldJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2WeldJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";

%feature("docstring") b2WeldJoint::GetAnchorA "Get the anchor point on bodyA in world coordinates.";

%feature("docstring") b2WeldJoint::GetAnchorB "Get the anchor point on bodyB in world coordinates.";

%feature("docstring") b2WeldJoint::GetReactionForce "Get the reaction force on body2 at the joint anchor in Newtons.";

%feature("docstring") b2WeldJoint::GetReactionTorque "Get the reaction torque on body2 in N*m.";


// File: structb2_weld_joint_def.xml
%feature("docstring") b2WeldJointDef "Weld joint definition. You need to specify local anchor points where they are attached and the relative body angle. The position of the anchor points is important for computing the reaction torque.";

%feature("docstring") b2WeldJointDef::Initialize "Initialize the bodies, anchors, and reference angle using a world anchor point.";

%feature("docstring") b2WeldJointDef::Initialize "Initialize the bodies, anchors, and reference angle using a world anchor point.";


// File: classb2_world.xml
%feature("docstring") b2World "The world class manages all physics entities, dynamic simulation, and asynchronous queries. The world also contains efficient memory management facilities.";

%feature("docstring") b2World::b2World "Construct a world object.

Parameters:
-----------

gravity: 
the world gravity vector.

doSleep: 
improve performance by not simulating inactive bodies.";

%feature("docstring") b2World::~b2World "Destruct the world. All physics entities are destroyed and all heap memory is released.";

%feature("docstring") b2World::SetDestructionListener "Register a destruction listener. The listener is owned by you and must remain in scope.";

%feature("docstring") b2World::SetContactFilter "Register a contact filter to provide specific control over collision. Otherwise the default filter is used (b2_defaultFilter). The listener is owned by you and must remain in scope.";

%feature("docstring") b2World::SetContactListener "Register a contact event listener. The listener is owned by you and must remain in scope.";

%feature("docstring") b2World::SetDebugDraw "Register a routine for debug drawing. The debug draw functions are called inside with  b2World::DrawDebugDatamethod. The debug draw object is owned by you and must remain in scope.";

%feature("docstring") b2World::CreateBody "Create a rigid body given a definition. No reference to the definition is retained. 
WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2World::DestroyBody "Destroy a rigid body given a definition. No reference to the definition is retained. This function is locked during callbacks. 
WARNING: 
This automatically deletes all associated shapes and joints. 
This function is locked during callbacks.";

%feature("docstring") b2World::CreateJoint "Create a joint to constrain bodies together. No reference to the definition is retained. This may cause the connected bodies to cease colliding. 
WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2World::DestroyJoint "Destroy a joint. This may cause the connected bodies to begin colliding. 
WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2World::Step "Take a time step. This performs collision detection, integration, and constraint solution.

Parameters:
-----------

timeStep: 
the amount of time to simulate, this should not vary.

velocityIterations: 
for the velocity constraint solver.

positionIterations: 
for the position constraint solver.";

%feature("docstring") b2World::ClearForces "Manually clear the force buffer on all bodies. By default, forces are cleared automatically after each call to Step. The default behavior is modified by calling SetAutoClearForces. The purpose of this function is to support sub-stepping. Sub-stepping is often used to maintain a fixed sized time step under a variable frame-rate. When you perform sub-stepping you will disable auto clearing of forces and instead call ClearForces after all sub-steps are complete in one pass of your game loop. 
See: 
 SetAutoClearForces";

%feature("docstring") b2World::DrawDebugData "Call this to draw shapes and other debug draw data.";

%feature("docstring") b2World::QueryAABB "Query the world for all fixtures that potentially overlap the provided AABB.

Parameters:
-----------

callback: 
a user implemented callback class.

aabb: 
the query box.";

%feature("docstring") b2World::RayCast "Ray-cast the world for all fixtures in the path of the ray. Your callback controls whether you get the closest point, any point, or n-points. The ray-cast ignores shapes that contain the starting point.

Parameters:
-----------

callback: 
a user implemented callback class.

point1: 
the ray starting point

point2: 
the ray ending point";

%feature("docstring") b2World::GetBodyList "Get the world body list. With the returned body, use  b2Body::GetNextto get the next body in the world list. A NULL body indicates the end of the list. 
the head of the world body list.";

%feature("docstring") b2World::GetJointList "Get the world joint list. With the returned joint, use  b2Joint::GetNextto get the next joint in the world list. A NULL joint indicates the end of the list. 
the head of the world joint list.";

%feature("docstring") b2World::GetContactList "Get the world contact list. With the returned contact, use  b2Contact::GetNextto get the next contact in the world list. A NULL contact indicates the end of the list. 
the head of the world contact list.

WARNING: 
contacts are";

%feature("docstring") b2World::SetWarmStarting "Enable/disable warm starting. For testing.";

%feature("docstring") b2World::SetContinuousPhysics "Enable/disable continuous physics. For testing.";

%feature("docstring") b2World::SetSubStepping "Enable/disable single stepped continuous physics. For testing.";

%feature("docstring") b2World::GetProxyCount "Get the number of broad-phase proxies.";

%feature("docstring") b2World::GetBodyCount "Get the number of bodies.";

%feature("docstring") b2World::GetJointCount "Get the number of joints.";

%feature("docstring") b2World::GetContactCount "Get the number of contacts (each may have 0 or more contact points).";

%feature("docstring") b2World::SetGravity "Change the global gravity vector.";

%feature("docstring") b2World::GetGravity "Get the global gravity vector.";

%feature("docstring") b2World::IsLocked "Is the world locked (in the middle of a time step).";

%feature("docstring") b2World::SetAutoClearForces "Set flag to control automatic clearing of forces after each time step.";

%feature("docstring") b2World::GetAutoClearForces "Get the flag that controls automatic clearing of forces after each time step.";

%feature("docstring") b2World::GetContactManager "Get the contact manager for testing.";

%feature("docstring") b2World::b2World "Construct a world object.

Parameters:
-----------

gravity: 
the world gravity vector.

doSleep: 
improve performance by not simulating inactive bodies.";

%feature("docstring") b2World::~b2World "Destruct the world. All physics entities are destroyed and all heap memory is released.";

%feature("docstring") b2World::SetDestructionListener "Register a destruction listener. The listener is owned by you and must remain in scope.";

%feature("docstring") b2World::SetContactFilter "Register a contact filter to provide specific control over collision. Otherwise the default filter is used (b2_defaultFilter). The listener is owned by you and must remain in scope.";

%feature("docstring") b2World::SetContactListener "Register a contact event listener. The listener is owned by you and must remain in scope.";

%feature("docstring") b2World::SetDebugDraw "Register a routine for debug drawing. The debug draw functions are called inside with  b2World::DrawDebugDatamethod. The debug draw object is owned by you and must remain in scope.";

%feature("docstring") b2World::CreateBody "Create a rigid body given a definition. No reference to the definition is retained. 
WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2World::DestroyBody "Destroy a rigid body given a definition. No reference to the definition is retained. This function is locked during callbacks. 
WARNING: 
This automatically deletes all associated shapes and joints. 
This function is locked during callbacks.";

%feature("docstring") b2World::CreateJoint "Create a joint to constrain bodies together. No reference to the definition is retained. This may cause the connected bodies to cease colliding. 
WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2World::DestroyJoint "Destroy a joint. This may cause the connected bodies to begin colliding. 
WARNING: 
This function is locked during callbacks.";

%feature("docstring") b2World::Step "Take a time step. This performs collision detection, integration, and constraint solution.

Parameters:
-----------

timeStep: 
the amount of time to simulate, this should not vary.

velocityIterations: 
for the velocity constraint solver.

positionIterations: 
for the position constraint solver.";

%feature("docstring") b2World::ClearForces "Manually clear the force buffer on all bodies. By default, forces are cleared automatically after each call to Step. The default behavior is modified by calling SetAutoClearForces. The purpose of this function is to support sub-stepping. Sub-stepping is often used to maintain a fixed sized time step under a variable frame-rate. When you perform sub-stepping you will disable auto clearing of forces and instead call ClearForces after all sub-steps are complete in one pass of your game loop. 
See: 
 SetAutoClearForces";

%feature("docstring") b2World::DrawDebugData "Call this to draw shapes and other debug draw data.";

%feature("docstring") b2World::QueryAABB "Query the world for all fixtures that potentially overlap the provided AABB.

Parameters:
-----------

callback: 
a user implemented callback class.

aabb: 
the query box.";

%feature("docstring") b2World::RayCast "Ray-cast the world for all fixtures in the path of the ray. Your callback controls whether you get the closest point, any point, or n-points. The ray-cast ignores shapes that contain the starting point.

Parameters:
-----------

callback: 
a user implemented callback class.

point1: 
the ray starting point

point2: 
the ray ending point";

%feature("docstring") b2World::GetBodyList "Get the world body list. With the returned body, use  b2Body::GetNextto get the next body in the world list. A NULL body indicates the end of the list. 
the head of the world body list.";

%feature("docstring") b2World::GetJointList "Get the world joint list. With the returned joint, use  b2Joint::GetNextto get the next joint in the world list. A NULL joint indicates the end of the list. 
the head of the world joint list.";

%feature("docstring") b2World::GetContactList "Get the world contact list. With the returned contact, use  b2Contact::GetNextto get the next contact in the world list. A NULL contact indicates the end of the list. 
the head of the world contact list.

WARNING: 
contacts are";

%feature("docstring") b2World::SetWarmStarting "Enable/disable warm starting. For testing.";

%feature("docstring") b2World::SetContinuousPhysics "Enable/disable continuous physics. For testing.";

%feature("docstring") b2World::SetSubStepping "Enable/disable single stepped continuous physics. For testing.";

%feature("docstring") b2World::GetProxyCount "Get the number of broad-phase proxies.";

%feature("docstring") b2World::GetBodyCount "Get the number of bodies.";

%feature("docstring") b2World::GetJointCount "Get the number of joints.";

%feature("docstring") b2World::GetContactCount "Get the number of contacts (each may have 0 or more contact points).";

%feature("docstring") b2World::SetGravity "Change the global gravity vector.";

%feature("docstring") b2World::GetGravity "Get the global gravity vector.";

%feature("docstring") b2World::IsLocked "Is the world locked (in the middle of a time step).";

%feature("docstring") b2World::SetAutoClearForces "Set flag to control automatic clearing of forces after each time step.";

%feature("docstring") b2World::GetAutoClearForces "Get the flag that controls automatic clearing of forces after each time step.";

%feature("docstring") b2World::GetContactManager "Get the contact manager for testing.";


// File: structb2_world_manifold.xml
%feature("docstring") b2WorldManifold "This is used to compute the current state of a contact manifold.";

%feature("docstring") b2WorldManifold::Initialize "Evaluate the manifold with supplied transforms. This assumes modest motion from the original state. This does not change the point count, impulses, etc. The radii must come from the shapes that generated the manifold.";

%feature("docstring") b2WorldManifold::Initialize "Evaluate the manifold with supplied transforms. This assumes modest motion from the original state. This does not change the point count, impulses, etc. The radii must come from the shapes that generated the manifold.";


// File: ___box2_d_2_collision_2b2_broad_phase_8h.xml
%feature("docstring") b2PairLessThan "This is used to sort pairs.";


// File: _collision_2b2_broad_phase_8h.xml
%feature("docstring") b2PairLessThan "This is used to sort pairs.";


// File: ___box2_d_2_collision_2b2_collide_circle_8cpp.xml
%feature("docstring") b2CollideCircles "Compute the collision manifold between two circles.";

%feature("docstring") b2CollidePolygonAndCircle "Compute the collision manifold between a polygon and a circle.";


// File: _collision_2b2_collide_circle_8cpp.xml
%feature("docstring") b2CollideCircles "Compute the collision manifold between two circles.";

%feature("docstring") b2CollidePolygonAndCircle "Compute the collision manifold between a polygon and a circle.";


// File: ___box2_d_2_collision_2b2_collide_edge_8cpp.xml
%feature("docstring") b2CollideEdgeAndCircle "Compute the collision manifold between an edge and a circle.";

%feature("docstring") b2CollideEdgeAndPolygon "Compute the collision manifold between an edge and a circle.";


// File: _collision_2b2_collide_edge_8cpp.xml
%feature("docstring") b2CollideEdgeAndCircle "Compute the collision manifold between an edge and a circle.";

%feature("docstring") b2CollideEdgeAndPolygon "Compute the collision manifold between an edge and a circle.";


// File: ___box2_d_2_collision_2b2_collide_polygon_8cpp.xml
%feature("docstring") b2CollidePolygons "Compute the collision manifold between two polygons.";


// File: _collision_2b2_collide_polygon_8cpp.xml
%feature("docstring") b2CollidePolygons "Compute the collision manifold between two polygons.";


// File: ___box2_d_2_collision_2b2_collision_8cpp.xml
%feature("docstring") b2GetPointStates "Compute the point states given two manifolds. The states pertain to the transition from manifold1 to manifold2. So state1 is either persist or remove while state2 is either add or persist.";

%feature("docstring") b2ClipSegmentToLine "Clipping for contact manifolds.";

%feature("docstring") b2TestOverlap "Determine if two generic shapes overlap.";


// File: _collision_2b2_collision_8cpp.xml
%feature("docstring") b2GetPointStates "Compute the point states given two manifolds. The states pertain to the transition from manifold1 to manifold2. So state1 is either persist or remove while state2 is either add or persist.";

%feature("docstring") b2ClipSegmentToLine "Clipping for contact manifolds.";

%feature("docstring") b2TestOverlap "Determine if two generic shapes overlap.";


// File: ___box2_d_2_collision_2b2_collision_8h.xml
%feature("docstring") b2GetPointStates "Compute the point states given two manifolds. The states pertain to the transition from manifold1 to manifold2. So state1 is either persist or remove while state2 is either add or persist.";

%feature("docstring") b2CollideCircles "Compute the collision manifold between two circles.";

%feature("docstring") b2CollidePolygonAndCircle "Compute the collision manifold between a polygon and a circle.";

%feature("docstring") b2CollidePolygons "Compute the collision manifold between two polygons.";

%feature("docstring") b2CollideEdgeAndCircle "Compute the collision manifold between an edge and a circle.";

%feature("docstring") b2CollideEdgeAndPolygon "Compute the collision manifold between an edge and a circle.";

%feature("docstring") b2ClipSegmentToLine "Clipping for contact manifolds.";

%feature("docstring") b2TestOverlap "Determine if two generic shapes overlap.";


// File: _collision_2b2_collision_8h.xml
%feature("docstring") b2GetPointStates "Compute the point states given two manifolds. The states pertain to the transition from manifold1 to manifold2. So state1 is either persist or remove while state2 is either add or persist.";

%feature("docstring") b2CollideCircles "Compute the collision manifold between two circles.";

%feature("docstring") b2CollidePolygonAndCircle "Compute the collision manifold between a polygon and a circle.";

%feature("docstring") b2CollidePolygons "Compute the collision manifold between two polygons.";

%feature("docstring") b2CollideEdgeAndCircle "Compute the collision manifold between an edge and a circle.";

%feature("docstring") b2CollideEdgeAndPolygon "Compute the collision manifold between an edge and a circle.";

%feature("docstring") b2ClipSegmentToLine "Clipping for contact manifolds.";

%feature("docstring") b2TestOverlap "Determine if two generic shapes overlap.";


// File: ___box2_d_2_collision_2b2_distance_8cpp.xml
%feature("docstring") b2Distance "Compute the closest points between two shapes. Supports any combination of:  b2CircleShape,  b2PolygonShape,  b2EdgeShape. The simplex cache is input/output. On the first call set b2SimplexCache.count to zero.";


// File: _collision_2b2_distance_8cpp.xml
%feature("docstring") b2Distance "Compute the closest points between two shapes. Supports any combination of:  b2CircleShape,  b2PolygonShape,  b2EdgeShape. The simplex cache is input/output. On the first call set b2SimplexCache.count to zero.";


// File: ___box2_d_2_collision_2b2_distance_8h.xml
%feature("docstring") b2Distance "Compute the closest points between two shapes. Supports any combination of:  b2CircleShape,  b2PolygonShape,  b2EdgeShape. The simplex cache is input/output. On the first call set b2SimplexCache.count to zero.";


// File: _collision_2b2_distance_8h.xml
%feature("docstring") b2Distance "Compute the closest points between two shapes. Supports any combination of:  b2CircleShape,  b2PolygonShape,  b2EdgeShape. The simplex cache is input/output. On the first call set b2SimplexCache.count to zero.";


// File: ___box2_d_2_collision_2b2_time_of_impact_8cpp.xml
%feature("docstring") b2TimeOfImpact "Compute the upper bound on time before two shapes penetrate. Time is represented as a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate, non-tunneling collision. If you change the time interval, you should call this function again. Note: use b2Distance to compute the contact point and normal at the time of impact.";


// File: _collision_2b2_time_of_impact_8cpp.xml
%feature("docstring") b2TimeOfImpact "Compute the upper bound on time before two shapes penetrate. Time is represented as a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate, non-tunneling collision. If you change the time interval, you should call this function again. Note: use b2Distance to compute the contact point and normal at the time of impact.";


// File: ___box2_d_2_collision_2b2_time_of_impact_8h.xml
%feature("docstring") b2TimeOfImpact "Compute the upper bound on time before two shapes penetrate. Time is represented as a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate, non-tunneling collision. If you change the time interval, you should call this function again. Note: use b2Distance to compute the contact point and normal at the time of impact.";


// File: _collision_2b2_time_of_impact_8h.xml
%feature("docstring") b2TimeOfImpact "Compute the upper bound on time before two shapes penetrate. Time is represented as a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate, non-tunneling collision. If you change the time interval, you should call this function again. Note: use b2Distance to compute the contact point and normal at the time of impact.";


// File: ___box2_d_2_common_2b2_math_8h.xml
%feature("docstring") b2IsValid "This function is used to ensure that a floating point number is not a NaN or infinity.";

%feature("docstring") b2InvSqrt "This is a approximate yet fast inverse square-root.";

%feature("docstring") b2Dot "Perform the dot product on two vectors.";

%feature("docstring") b2Cross "Perform the cross product on two vectors. In 2D this produces a scalar.";

%feature("docstring") b2Cross "Perform the cross product on a vector and a scalar. In 2D this produces a vector.";

%feature("docstring") b2Cross "Perform the cross product on a scalar and a vector. In 2D this produces a vector.";

%feature("docstring") b2Mul "Multiply a matrix times a vector. If a rotation matrix is provided, then this transforms the vector from one frame to another.";

%feature("docstring") b2MulT "Multiply a matrix transpose times a vector. If a rotation matrix is provided, then this transforms the vector from one frame to another (inverse transform).";

%feature("docstring") b2Dot "Perform the dot product on two vectors.";

%feature("docstring") b2Cross "Perform the cross product on two vectors.";

%feature("docstring") b2Mul "Multiply a matrix times a vector.";

%feature("docstring") b2NextPowerOfTwo "\"Next Largest Power of 2 Given a binary integer value x, the next largest power of 2 can be computed by a SWAR algorithm that recursively \"folds\" the upper bits into the lower bits. This process yields a bit vector with the same most significant 1 as x, but all 1's below it. Adding 1 to that value yields the next largest power of 2. For a 32-bit value:\"";


// File: _common_2b2_math_8h.xml
%feature("docstring") b2IsValid "This function is used to ensure that a floating point number is not a NaN or infinity.";

%feature("docstring") b2InvSqrt "This is a approximate yet fast inverse square-root.";

%feature("docstring") b2Dot "Perform the dot product on two vectors.";

%feature("docstring") b2Cross "Perform the cross product on two vectors. In 2D this produces a scalar.";

%feature("docstring") b2Cross "Perform the cross product on a vector and a scalar. In 2D this produces a vector.";

%feature("docstring") b2Cross "Perform the cross product on a scalar and a vector. In 2D this produces a vector.";

%feature("docstring") b2Mul "Multiply a matrix times a vector. If a rotation matrix is provided, then this transforms the vector from one frame to another.";

%feature("docstring") b2MulT "Multiply a matrix transpose times a vector. If a rotation matrix is provided, then this transforms the vector from one frame to another (inverse transform).";

%feature("docstring") b2Dot "Perform the dot product on two vectors.";

%feature("docstring") b2Cross "Perform the cross product on two vectors.";

%feature("docstring") b2Mul "Multiply a matrix times a vector.";

%feature("docstring") b2NextPowerOfTwo "\"Next Largest Power of 2 Given a binary integer value x, the next largest power of 2 can be computed by a SWAR algorithm that recursively \"folds\" the upper bits into the lower bits. This process yields a bit vector with the same most significant 1 as x, but all 1's below it. Adding 1 to that value yields the next largest power of 2. For a 32-bit value:\"";


// File: ___box2_d_2_common_2b2_settings_8cpp.xml
%feature("docstring") b2Alloc "Implement this function to use your own memory allocator.";

%feature("docstring") b2Free "If you implement b2Alloc, you should also implement this function.";


// File: _common_2b2_settings_8cpp.xml
%feature("docstring") b2Alloc "Implement this function to use your own memory allocator.";

%feature("docstring") b2Free "If you implement b2Alloc, you should also implement this function.";


// File: ___box2_d_2_common_2b2_settings_8h.xml
%feature("docstring") b2Alloc "Implement this function to use your own memory allocator.";

%feature("docstring") b2Free "If you implement b2Alloc, you should also implement this function.";

%feature("docstring") b2MixFriction "Friction mixing law. Feel free to customize this.";

%feature("docstring") b2MixRestitution "Restitution mixing law. Feel free to customize this.";


// File: _common_2b2_settings_8h.xml
%feature("docstring") b2Alloc "Implement this function to use your own memory allocator.";

%feature("docstring") b2Free "If you implement b2Alloc, you should also implement this function.";

%feature("docstring") b2MixFriction "Friction mixing law. Feel free to customize this.";

%feature("docstring") b2MixRestitution "Restitution mixing law. Feel free to customize this.";

