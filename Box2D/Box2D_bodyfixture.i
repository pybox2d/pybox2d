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

/**** BodyDef ****/
%extend b2BodyDef {
public:        
    %pythoncode %{
        fixtures = None
        shapes = None
        shapeFixture = None
    %}
}

/**** FixtureDef ****/
/* Special initializer to allow for filter arguments */
%extend b2FixtureDef {
public:
    %pythoncode %{
        def __SetCategoryBits(self, value):
            self.filter.categoryBits=value
        def __SetGroupIndex(self, value):
            self.filter.groupIndex=value
        def __SetMaskBits(self, value):
            self.filter.maskBits=value

        categoryBits=property(lambda self: self.filter.categoryBits, __SetCategoryBits)
        groupIndex=property(lambda self: self.filter.groupIndex, __SetGroupIndex)
        maskBits=property(lambda self: self.filter.maskBits, __SetMaskBits)
    %}
}

/**** Fixture ****/
%extend b2Fixture {
public:
    long __hash__() { return (long)self; }
    /* This destructor is ignored by SWIG, but it stops the erroneous
    memory leak error. Will have to test with older versions of SWIG
    to ensure this is ok (tested with 1.3.40)
    */
    ~b2Fixture() {
    }

    %pythoncode %{
        __eq__ = b2FixtureCompare
        __ne__ = lambda self,other: not b2FixtureCompare(self,other)

        # Read-write properties
        friction = property(__GetFriction, __SetFriction)
        restitution = property(__GetRestitution, __SetRestitution)
        filterData = property(__GetFilterData, __SetFilterData)
        sensor = property(__IsSensor, __SetSensor)
        density = property(__GetDensity, __SetDensity)

        # Read-only
        next = property(__GetNext, None)
        type = property(__GetType, None)
        shape = property(__GetShape, None)
        body = property(__GetBody, None)
        
        @property
        def massData(self):
            md=b2MassData()
            self.__GetMassData(md)
            return md
    %}
}

%rename(__GetNext) b2Fixture::GetNext;
%rename(__GetFriction) b2Fixture::GetFriction;
%rename(__GetRestitution) b2Fixture::GetRestitution;
%rename(__GetFilterData) b2Fixture::GetFilterData;
%rename(__IsSensor) b2Fixture::IsSensor;
%rename(__GetType) b2Fixture::GetType;
%rename(__GetMassData) b2Fixture::GetMassData;
%rename(__GetShape) b2Fixture::GetShape;
%rename(__GetDensity) b2Fixture::GetDensity;
%rename(__GetBody) b2Fixture::GetBody;
%rename(__SetSensor) b2Fixture::SetSensor;
%rename(__SetDensity) b2Fixture::SetDensity;
%rename(__SetFilterData) b2Fixture::SetFilterData;
%rename(__SetFriction) b2Fixture::SetFriction;
%rename(__SetRestitution) b2Fixture::SetRestitution;

/**** Body ****/
%extend b2Body {
public:
    long __hash__() { return (long)self; }
    %pythoncode %{
        __eq__ = b2BodyCompare
        __ne__ = lambda self,other: not b2BodyCompare(self,other)
        def __GetMassData(self):
            """
            Get a b2MassData object that represents this b2Body

            NOTE: To just get the mass, use body.mass
            """
            ret = b2MassData()
            ret.center=self.localCenter
            ret.I    = self.inertia
            ret.mass = self.mass
            return ret

        def __SetInertia(self, inertia):
            """
            Set the body's inertia
            """
            md = self.massData
            md.I = inertia
            self.massData=md

        def __SetMass(self, mass):
            """
            Set the body's mass
            """
            md = self.massData
            md.mass = mass
            self.massData=md

        def __SetLocalCenter(self, lcenter):
            """
            Set the body's local center
            """
            md = self.massData
            md.center = lcenter
            self.massData=md

        def __iter__(self):
            """
            Iterates over the fixtures in the body
            """
            for fixture in self.fixtures:
                yield fixture

        def __CreateShapeFixture(self, type_, **kwargs):
            """
            Internal function to handle creating circles, polygons, etc.
            without first creating a fixture. type_ is b2Shape.
            """
            shape=type_()
            fixture=b2FixtureDef(shape=shape)
            
            for key, value in list(kwargs.items()):
                # Note that these hasattrs use the types to get around
                # the fact that some properties are write-only (like 'box' in
                # polygon shapes), and as such do not show up with 'hasattr'.
                if hasattr(type_, key):
                    to_set=shape
                elif hasattr(b2FixtureDef, key):
                    to_set=fixture
                else:
                    raise AttributeError('Property %s not found in either %s or b2FixtureDef' % (key, type_.__name__))

                try:
                    setattr(to_set, key, value)
                except Exception as ex:
                    raise ex.__class__('Failed on kwargs, class="%s" key="%s": %s' \
                                % (to_set.__class__.__name__, key, ex))

            return self.CreateFixture(fixture)

        def CreatePolygonFixture(self, **kwargs):
            """
            Create a polygon shape without an explicit fixture definition.

            Takes kwargs; you can pass in properties for either the polygon
            or the fixture to this function. For example:
            CreatePolygonFixture(box=(1, 1), friction=0.2, density=1.0)
            where 'box' is a property from the polygon shape, and 
            'friction' and 'density' are from the fixture definition.
            """
            return self.__CreateShapeFixture(b2PolygonShape, **kwargs)

        def CreateCircleFixture(self, **kwargs):
            """
            Create a circle shape without an explicit fixture definition.

            Takes kwargs; you can pass in properties for either the circle
            or the fixture to this function. For example:
            CreateCircleFixture(radius=0.2, friction=0.2, density=1.0)
            where 'radius' is a property from the circle shape, and 
            'friction' and 'density' are from the fixture definition.
            """
            return self.__CreateShapeFixture(b2CircleShape, **kwargs)

        def CreateEdgeFixture(self, **kwargs):
            """
            Create a edge shape without an explicit fixture definition.

            Takes kwargs; you can pass in properties for either the edge
            or the fixture to this function. For example:
            CreateEdgeFixture(vertices=[(0,0),(1,0)], friction=0.2, density=1.0)
            where 'vertices' is a property from the edge shape, and 
            'friction' and 'density' are from the fixture definition.
            """
            return self.__CreateShapeFixture(b2EdgeShape, **kwargs)

        def CreateLoopFixture(self, **kwargs):
            """
            Create a loop shape without an explicit fixture definition.

            Takes kwargs; you can pass in properties for either the loop
            or the fixture to this function. For example:
            CreateLoopFixture(vertices=[...], friction=0.2, density=1.0)
            where 'vertices' is a property from the loop shape, and 
            'friction' and 'density' are from the fixture definition.
            """
            return self.__CreateShapeFixture(b2LoopShape, **kwargs)

        def CreateFixturesFromShapes(self, shapes=None, shapeFixture=None):
            """
            Create fixture(s) on the body from one or more shapes, and optionally a single
            fixture definition.

            Takes kwargs; examples of valid combinations are as follows:
            CreateFixturesFromShapes(shapes=b2CircleShape(radius=0.2))
            CreateFixturesFromShapes(shapes=b2CircleShape(radius=0.2), shapeFixture=b2FixtureDef(friction=0.2))
            CreateFixturesFromShapes(shapes=[b2CircleShape(radius=0.2), b2PolygonShape(box=[1,2])])
            """
            if shapes==None:
                raise TypeError('At least one shape required')

            if shapeFixture==None:
                shapeFixture=b2FixtureDef()
                oldShape=None
            else:
                oldShape = shapeFixture.shape

            ret=None
            if isinstance(shapes, (list, tuple)):
                ret=[]
                for shape in shapes:
                    shapeFixture.shape=shape
                    ret.append(self.__CreateFixture(shapeFixture))
            else:
                shapeFixture.shape=shapes
                ret=self.__CreateFixture(shapeFixture)

            shapeFixture.shape=oldShape
            return ret

        def CreateFixture(self, *args, **kwargs):
            """
            Create a fixtures on the body.

            Takes kwargs; examples of valid combinations are as follows:
            CreateFixture(b2FixtureDef(shape=s, restitution=0.2, ...))
            CreateFixture(shape=s, restitution=0.2, ...)
            
            """
            if len(args) > 1:
                raise TypeError('Takes only one argument or kwargs. See help(b2Body.CreateFixture)')
            elif len(args)==1:
                if isinstance(args[0], b2FixtureDef):
                    defn = args[0]
                    return self.__CreateFixture(defn)
                else:
                    raise TypeError('Expected b2FixtureDef argument or kwargs')
            else: # no arguments, just kwargs
                return self.__CreateFixture(b2FixtureDef(**kwargs))

        def CreateEdgeChain(self, edge_list):
            """
            Creates a body a set of connected edge chains.
            Expects edge_list to be a list of vertices, length >= 2.
            """
            prev=None
            if len(edge_list) < 2:
                raise ValueError('Edge list length >= 2')

            shape=b2EdgeShape(vertices=[list(i) for i in edge_list[0:2]])
            self.CreateFixturesFromShapes(shape)

            prev = edge_list[1]
            for edge in edge_list[1:]:
                if len(edge) != 2:
                    raise ValueError('Vertex length != 2, "%s"' % list(edge))
                shape.vertices = [list(prev), list(edge)]
                self.CreateFixturesFromShapes(shape)
                prev=edge

        # Read-write properties
        sleepingAllowed = property(__IsSleepingAllowed, __SetSleepingAllowed)
        angularVelocity = property(__GetAngularVelocity, __SetAngularVelocity)
        linearVelocity = property(__GetLinearVelocity, __SetLinearVelocity)
        awake = property(__IsAwake, __SetAwake)
        angularDamping = property(__GetAngularDamping, __SetAngularDamping)
        fixedRotation = property(__IsFixedRotation, __SetFixedRotation)
        linearDamping = property(__GetLinearDamping, __SetLinearDamping)
        bullet = property(__IsBullet, __SetBullet)
        type = property(__GetType, __SetType)
        active = property(__IsActive, __SetActive)
        angle = property(__GetAngle, lambda self, angle: self.__SetTransform(self.position, angle))
        transform = property(__GetTransform, lambda self, value: self.__SetTransform(*value))
        massData = property(__GetMassData, __SetMassData)
        mass = property(__GetMass, __SetMass)
        localCenter = property(__GetLocalCenter, __SetLocalCenter)
        inertia = property(__GetInertia, __SetInertia)
        position = property(__GetPosition, lambda self, pos: self.__SetTransform(pos, self.angle))
        gravityScale = property(__GetGravityScale, __SetGravityScale)

        # Read-only
        joints = property(lambda self: _list_from_linked_list(self.__GetJointList_internal()), None, 
                            doc="""All joints connected to the body as a list. 
                            NOTE: This re-creates the list on every call. See also joints_gen.""")
        contacts = property(lambda self: _list_from_linked_list(self.__GetContactList_internal()), None,
                            doc="""All contacts related to the body as a list. 
                            NOTE: This re-creates the list on every call. See also contacts_gen.""")
        fixtures = property(lambda self: _list_from_linked_list(self.__GetFixtureList_internal()), None,
                            doc="""All fixtures contained in this body as a list. 
                            NOTE: This re-creates the list on every call. See also fixtures_gen.""")
        joints_gen = property(lambda self: _indexable_generator(_generator_from_linked_list(self.__GetJointList_internal())), None,
                            doc="""Indexable generator of the connected joints to this body.
                            NOTE: When not using the whole list, this may be preferable to using 'joints'.""")
        contacts_gen = property(lambda self: _indexable_generator(_generator_from_linked_list(self.__GetContactList_internal())), None,
                            doc="""Indexable generator of the related contacts.
                            NOTE: When not using the whole list, this may be preferable to using 'contacts'.""")
        fixtures_gen = property(lambda self: _indexable_generator(_generator_from_linked_list(self.__GetFixtureList_internal())), None,
                            doc="""Indexable generator of the contained fixtures.
                            NOTE: When not using the whole list, this may be preferable to using 'fixtures'.""")
        next = property(__GetNext, None)
        worldCenter = property(__GetWorldCenter, None)
        world = property(__GetWorld, None)
       
    %}
}

%rename(__GetAngle) b2Body::GetAngle;
%rename(__IsSleepingAllowed) b2Body::IsSleepingAllowed;
%rename(__GetAngularVelocity) b2Body::GetAngularVelocity;
%rename(__GetJointList_internal) b2Body::GetJointList;
%rename(__GetFixtureList_internal) b2Body::GetFixtureList;
%rename(__GetContactList_internal) b2Body::GetContactList;
%rename(__GetLinearVelocity) b2Body::GetLinearVelocity;
%rename(__GetNext) b2Body::GetNext;
%rename(__GetPosition) b2Body::GetPosition;
%rename(__GetMass) b2Body::GetMass;
%rename(__IsAwake) b2Body::IsAwake;
%rename(__GetTransform) b2Body::GetTransform;
%rename(__SetTransform) b2Body::SetTransform;
%rename(__GetGravityScale) b2Body::GetGravityScale;
%rename(__SetGravityScale) b2Body::SetGravityScale;
%rename(__GetWorldCenter) b2Body::GetWorldCenter;
%rename(__GetAngularDamping) b2Body::GetAngularDamping;
%rename(__IsFixedRotation) b2Body::IsFixedRotation;
%rename(__GetWorld) b2Body::GetWorld;
%rename(__GetLinearDamping) b2Body::GetLinearDamping;
%rename(__IsBullet) b2Body::IsBullet;
%rename(__GetLocalCenter) b2Body::GetLocalCenter;
%rename(__GetType) b2Body::GetType;
%rename(__GetInertia) b2Body::GetInertia;
%rename(__IsActive) b2Body::IsActive;
%rename(__SetLinearVelocity) b2Body::SetLinearVelocity;
%rename(__SetSleepingAllowed) b2Body::SetSleepingAllowed;
%rename(__SetAngularDamping) b2Body::SetAngularDamping;
%rename(__SetActive) b2Body::SetActive;
%rename(__SetAngularVelocity) b2Body::SetAngularVelocity;
%rename(__SetMassData) b2Body::SetMassData;
%rename(__SetBullet) b2Body::SetBullet;
%rename(__SetFixedRotation) b2Body::SetFixedRotation;
%rename(__SetAwake) b2Body::SetAwake;
%rename(__SetLinearDamping) b2Body::SetLinearDamping;
%rename(__SetType) b2Body::SetType;

//
