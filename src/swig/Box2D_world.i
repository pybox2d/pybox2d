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

// i /really/ did not understand kwargs, apparently...
%feature("shadow") b2World::b2World(const b2Vec2& gravity) {
    def __init__(self, gravity=(0, -10), doSleep=True, **kwargs): 
        """__init__(self, gravity=(0, -10), doSleep=True, **kwargs) -> b2World

        Additional kwargs like contactListener will be passed after the world is created.

        Examples:
         b2World(gravity=(0,-10), doSleep=True)
         b2World(contactListener=myListener)
        """
        self.__data = {}
        _Box2D.b2World_swiginit(self,_Box2D.new_b2World(gravity))

        self.allowSleeping = doSleep

        for key, value in kwargs.items():
            try:
                setattr(self, key, value)
            except Exception as ex:
                raise ex.__class__('Failed on kwargs, class="%s" key="%s": %s' \
                            % (self.__class__.__name__, key, ex))
}

%extend b2World {
public:        
    %pythoncode %{
        def __iter__(self):
            """
            Iterates over the bodies in the world
            """
            for body in self.bodies:
                yield body

        def CreateDynamicBody(self, **kwargs):
            """
            Create a single dynamic body in the world.

            Accepts only kwargs to a b2BodyDef. For more information, see
            CreateBody and b2BodyDef.
            """
            kwargs['type'] = b2_dynamicBody
            return self.CreateBody(**kwargs)

        def CreateKinematicBody(self, **kwargs):
            """
            Create a single kinematic body in the world.

            Accepts only kwargs to a b2BodyDef. For more information, see
            CreateBody and b2BodyDef.
            """
            kwargs['type'] = b2_kinematicBody
            return self.CreateBody(**kwargs)

        def CreateStaticBody(self, **kwargs):
            """
            Create a single static body in the world.

            Accepts only kwargs to a b2BodyDef. For more information, see
            CreateBody and b2BodyDef.
            """
            kwargs['type'] = b2_staticBody
            return self.CreateBody(**kwargs)

        def CreateBody(self, defn=None, **kwargs):
            """
            Create a body in the world.
            Takes a single b2BodyDef argument, or kwargs to pass to a temporary b2BodyDef.
            world.CreateBody(position=(1,2), angle=1) 
            is short for:
            world.CreateBody(b2BodyDef(position=(1,2), angle=1))

            If the definition (or kwargs) sets 'fixtures', they will be created on the 
            newly created body. A single fixture is also accepted.

            CreateBody(..., fixtures=[])
            
            This is short for:
                body = CreateBody(...)
                for fixture in []:
                    body.CreateFixture(fixture)

             'shapes' and 'shapeFixture' are also accepted:
             CreateBody(..., shapes=[], shapeFixture=b2FixtureDef())
            
            This is short for:
                body = CreateBody(...)
                body.CreateFixturesFromShapes(shapes=[], shapeFixture=b2FixtureDef())
            """
            if defn is not None:
                if not isinstance(defn, b2BodyDef):
                    raise TypeError('Expected b2BodyDef')
            else:
                defn = b2BodyDef(**kwargs) 

            body=self.__CreateBody(defn)
                
            if defn.fixtures:
                if isinstance(defn.fixtures, (list, tuple)):
                    for fixture in defn.fixtures:
                        body.CreateFixture(fixture)
                else:
                    body.CreateFixture(defn.fixtures)
            if defn.shapes:
                body.CreateFixturesFromShapes(shapes=defn.shapes, shapeFixture=defn.shapeFixture)

            if 'massData' in kwargs:
                body.massData=kwargs['massData']
            if 'localCenter' in kwargs:
                body.localCenter=kwargs['localCenter']
            if 'inertia' in kwargs:
                body.inertia=kwargs['inertia']
            if 'mass' in kwargs:
                body.mass=kwargs['mass']

            return body

        def CreateDistanceJoint(self, bodyA=None, bodyB=None, **kwargs):
            """
            Create a single b2DistanceJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if bodyA is None or bodyB is None:
                raise ValueError('Requires at least bodyA and bodyB be set')

            return self.__CreateJoint(b2DistanceJointDef(bodyA=bodyA, bodyB=bodyB, **kwargs))

        def CreateRopeJoint(self, **kwargs):
            """
            Create a single b2RopeJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2RopeJointDef(**kwargs))

        def CreateFrictionJoint(self, **kwargs):
            """
            Create a single b2FrictionJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2FrictionJointDef(**kwargs))

        def CreateGearJoint(self, **kwargs):
            """
            Create a single b2GearJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either joint1 or joint2 is left unset.
            """
            if 'joint1' not in kwargs or 'joint2' not in kwargs:
                raise ValueError('Gear joint requires that both joint1 and joint2 be set')
            return self.__CreateJoint(b2GearJointDef(**kwargs))

        def CreateWheelJoint(self, **kwargs):
            """
            Create a single b2WheelJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2WheelJointDef(**kwargs))

        def CreateMouseJoint(self, **kwargs):
            """
            Create a single b2MouseJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2MouseJointDef(**kwargs))

        def CreatePrismaticJoint(self, **kwargs):
            """
            Create a single b2PrismaticJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2PrismaticJointDef(**kwargs))

        def CreatePulleyJoint(self, **kwargs):
            """
            Create a single b2PulleyJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2PulleyJointDef(**kwargs))

        def CreateRevoluteJoint(self, **kwargs):
            """
            Create a single b2RevoluteJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2RevoluteJointDef(**kwargs))

        def CreateWeldJoint(self, **kwargs):
            """
            Create a single b2WeldJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2WeldJointDef(**kwargs))

        def CreateMotorJoint(self, **kwargs):
            """
            Create a single b2MotorJoint. Only accepts kwargs to the joint definition.

            Raises ValueError if either bodyA or bodyB is left unset.
            """
            if 'bodyA' not in kwargs or 'bodyB' not in kwargs:
                raise ValueError('Requires at least bodyA and bodyB be set')
            return self.__CreateJoint(b2MotorJointDef(**kwargs))

        def CreateJoint(self, defn=None, type=None, **kwargs):
            """
            Create a joint in the world.
            Takes a single b2JointDef argument, or kwargs to pass to a temporary b2JointDef.

            All of these are exactly equivalent:
            world.CreateJoint(type=b2RevoluteJoint, bodyA=body, bodyB=body2)
            world.CreateJoint(type=b2RevoluteJointDef, bodyA=body, bodyB=body2)
            world.CreateJoint(b2RevoluteJointDef(bodyA=body, bodyB=body2))
            """
            if defn is not None:
                if not isinstance(defn, b2JointDef):
                    raise TypeError('Expected b2JointDef')
                if defn.bodyA is None or defn.bodyB is None:
                    raise ValueError('bodyA and bodyB must be set')
            else:
                if type is not None:
                    if issubclass(type, b2JointDef):
                        class_type = type
                    elif issubclass(type, b2Joint):  # a b2Joint passed in, so get the b2JointDef
                        class_type = globals()[type.__name__ + 'Def']
                    else:
                        raise TypeError('Expected "type" to be a b2Joint or b2JointDef')
                else:
                    raise TypeError('Expected "type" to be a b2Joint or b2JointDef')

                defn = class_type(**kwargs) 

            if isinstance(defn, b2GearJointDef):
                if not defn.joint1 or not defn.joint2:
                    raise ValueError('Gear joint requires that both joint1 and joint2 be set')
            else:
                if not defn.bodyA or not defn.bodyB:
                    raise ValueError('Body or bodies not set (bodyA, bodyB)')

            return self.__CreateJoint(defn)

        # The logic behind these functions is that they increase the refcount
        # of the listeners as you set them, so it is no longer necessary to keep
        # a copy on your own. Upon destruction of the object, it should be cleared
        # also clearing the refcount of the function.
        # Now using it also to buffer previously write-only values in the shadowed
        # class to make them read-write.
        def __GetData(self, name):
            return self.__data.get(name)

        def __SetData(self, name, value, fcn):
            self.__data[name] = value
            fcn(value)

        # Read-write properties
        gravity   = property(__GetGravity, __SetGravity)
        autoClearForces = property(__GetAutoClearForces, __SetAutoClearForces)
        destructionListener = property(lambda self: self.__GetData('destruction'), 
                                       lambda self, fcn: self.__SetData('destruction', fcn, self.__SetDestructionListener_internal))
        contactListener= property(lambda self: self.__GetData('contact'), 
                                  lambda self, fcn: self.__SetData('contact', fcn, self.__SetContactListener_internal))
        contactFilter= property(lambda self: self.__GetData('contactfilter'),
                                lambda self, fcn: self.__SetData('contactfilter', fcn, self.__SetContactFilter_internal))
        renderer= property(lambda self: self.__GetData('renderer'),
                            lambda self, fcn: self.__SetData('renderer', fcn, self.__SetDebugDraw_internal))

        continuousPhysics = property(__GetContinuousPhysics, __SetContinuousPhysics)
        warmStarting = property(__GetWarmStarting, __SetWarmStarting)
        subStepping = property(__GetSubStepping, __SetSubStepping)

        # Read-only 
        contactManager= property(__GetContactManager, None)
        contactCount  = property(__GetContactCount, None)
        bodyCount     = property(__GetBodyCount, None)
        jointCount    = property(__GetJointCount, None)
        proxyCount    = property(__GetProxyCount, None)
        joints  = property(lambda self: _list_from_linked_list(self.__GetJointList_internal()), None,
                            doc="""All joints in the world.  NOTE: This re-creates the list on every call. See also joints_gen.""")
        bodies  = property(lambda self: _list_from_linked_list(self.__GetBodyList_internal()), None,
                            doc="""All bodies in the world.  NOTE: This re-creates the list on every call. See also bodies_gen.""")
        contacts= property(lambda self: _list_from_linked_list(self.__GetContactList_internal()), None,
                            doc="""All contacts in the world.  NOTE: This re-creates the list on every call. See also contacts_gen.""")
        joints_gen = property(lambda self: _indexable_generator(_generator_from_linked_list(self.__GetJointList_internal())), None,
                            doc="""Indexable generator of the connected joints to this body.
                            NOTE: When not using the whole list, this may be preferable to using 'joints'.""")
        bodies_gen = property(lambda self: _indexable_generator(_generator_from_linked_list(self.__GetBodyList_internal())), None,
                            doc="""Indexable generator of all bodies.
                            NOTE: When not using the whole list, this may be preferable to using 'bodies'.""")
        contacts_gen = property(lambda self: _indexable_generator(_generator_from_linked_list(self.__GetContactList_internal())), None,
                            doc="""Indexable generator of all contacts.
                            NOTE: When not using the whole list, this may be preferable to using 'contacts'.""")
        locked  = property(__IsLocked, None)

        DrawDebugData = DebugDraw  # backward-compatibility
    %}
}

%rename (__GetGravity) b2World::GetGravity;
%rename (__SetGravity) b2World::SetGravity;
%rename (__GetJointList_internal) b2World::GetJointList;
%rename (__GetJointCount) b2World::GetJointCount;
%rename (__GetBodyList_internal) b2World::GetBodyList;
%rename (__GetContactList_internal) b2World::GetContactList;
%rename (__SetDestructionListener_internal) b2World::SetDestructionListener;
%rename (__SetContactFilter_internal) b2World::SetContactFilter;
%rename (__SetContactListener_internal) b2World::SetContactListener;
%rename (__SetDebugDraw_internal) b2World::SetDebugDraw;
%rename (__GetContactCount) b2World::GetContactCount;
%rename (__GetProxyCount) b2World::GetProxyCount;
%rename (__GetBodyCount) b2World::GetBodyCount;
%rename (__IsLocked) b2World::IsLocked;
%rename (__SetContinuousPhysics_internal) b2World::SetContinuousPhysics;
%rename (__SetWarmStarting_internal) b2World::SetWarmStarting;
%rename (__SetSubStepping_internal) b2World::SetSubStepping;
%rename (__SetAutoClearForces) b2World::SetAutoClearForces;
%rename (__GetAutoClearForces) b2World::GetAutoClearForces;
%rename (__GetContactManager) b2World::GetContactManager;

%rename (__GetContinuousPhysics) b2World::GetContinuousPhysics;
%rename (__SetContinuousPhysics) b2World::SetContinuousPhysics;
%rename (__GetWarmStarting) b2World::GetWarmStarting;
%rename (__SetWarmStarting) b2World::SetWarmStarting;
%rename (__GetSubStepping) b2World::GetSubStepping;
%rename (__SetSubStepping) b2World::SetSubStepping;
