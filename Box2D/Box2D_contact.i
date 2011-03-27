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

/**** b2GetPointStates ****/
%inline {
    PyObject* b2GetPointStates(const b2Manifold* manifold1, const b2Manifold* manifold2) {
        PyObject* ret=NULL;
        b2PointState state1[b2_maxManifoldPoints], state2[b2_maxManifoldPoints];

        if (!manifold1 || !manifold2)
            return NULL;

        b2GetPointStates(state1, state2, manifold1, manifold2);

        ret = PyTuple_New(2);
        
        int state1_length=-1, state2_length=-1;
        PyObject* state1_t=Py_None;
        PyObject* state2_t=Py_None;
        for (int i=0; i < b2_maxManifoldPoints; i++) {
            if (state1[i]==b2_nullState && state1_length==0)
                state1_length=i;
                if (state2_length > -1)
                    break;
            if (state2[i]==b2_nullState && state2_length==0)
                state2_length=i;
                if (state1_length > -1)
                    break;
        }

        if (state1_length < 0)
            state1_length = b2_maxManifoldPoints;
        if (state2_length < 0)
            state2_length = b2_maxManifoldPoints;

        if (state1_length > -1)
            state1_t=PyTuple_New(state1_length);
        else
            Py_INCREF(state1_t);

        if (state2_length > -1)
            state2_t=PyTuple_New(state2_length);
        else
            Py_INCREF(state2_t);

        PyTuple_SetItem(ret, 0, state1_t);
        PyTuple_SetItem(ret, 1, state2_t);

        for (int i=0; i < b2Max(state1_length, state2_length); i++) {
            if (i < state1_length)
                PyTuple_SetItem(state1_t, i, SWIG_From_int(state1[i]));
            if (i < state2_length)
                PyTuple_SetItem(state2_t, i, SWIG_From_int(state2[i]));
        }
        return ret;
   }
}
%ignore b2GetPointStates;

/**** Manifold ****/
%rename (type_) b2Manifold::type;
%ignore b2Manifold::points;

%extend b2Manifold {
public:
    %pythoncode %{
        def __GetPoints(self):
            return [self.__GetPoint(i) for i in range(self.pointCount)]
        points = property(__GetPoints, None)
    %}

    b2ManifoldPoint* __GetPoint(int i) {
        if (i >= b2_maxManifoldPoints || i >= $self->pointCount)
            return NULL;
        return &( $self->points[i] );
    }
    
}

/**** ContactManager ****/
%rename(broadPhase) b2ContactManager::m_broadPhase;
%rename(contactList) b2ContactManager::m_contactList;
%rename(contactCount) b2ContactManager::m_contactCount;
%rename(contactFilter) b2ContactManager::m_contactFilter;
%rename(contactListener) b2ContactManager::m_contactListener;
%rename(allocator) b2ContactManager::m_allocator;

%extend b2ContactManager {
public:
    // TODO contact lists, etc. same as b2World
    %pythoncode %{
    %}
}


/* ContactImpulse */
%extend b2ContactImpulse {
public:
    //float32 normalImpulses[b2_maxManifoldPoints];
    //float32 tangentImpulses[b2_maxManifoldPoints];
    PyObject* __get_normal_impulses() {
        PyObject* ret = PyTuple_New(b2_maxManifoldPoints);
        for (int i=0; i < b2_maxManifoldPoints; i++)
            PyTuple_SetItem(ret, i, SWIG_From_double((float32)($self->normalImpulses[i])));
        return ret;
    }
    PyObject* __get_tangent_impulses() {
        PyObject* ret = PyTuple_New(b2_maxManifoldPoints);
        for (int i=0; i < b2_maxManifoldPoints; i++)
            PyTuple_SetItem(ret, i, SWIG_From_double((float32)($self->tangentImpulses[i])));
        return ret;
    }

    %pythoncode %{
        normalImpulses = property(__get_normal_impulses, None)
        tangentImpulses = property(__get_tangent_impulses, None)
    %}

}

%ignore b2ContactImpulse::normalImpulses;
%ignore b2ContactImpulse::tangentImpulses;

/**** WorldManifold ****/
%ignore b2WorldManifold::points;

%extend b2WorldManifold {
public:
    %pythoncode %{
    %}

    PyObject* __GetPoints() {
        PyObject* ret=PyTuple_New(b2_maxManifoldPoints);
        PyObject* point;
        for (int i=0; i < b2_maxManifoldPoints; i++) {
            point = PyTuple_New(2);
            PyTuple_SetItem(point, 0, SWIG_From_double((float32)$self->points[i].x));
            PyTuple_SetItem(point, 1, SWIG_From_double((float32)$self->points[i].y));

            PyTuple_SetItem(ret, i, point);
        }
        return ret;
    }
    %pythoncode %{
        points = property(__GetPoints, None)
    %}
}


/**** Contact ****/
%extend b2Contact {
public:
    %pythoncode %{
        def __GetWorldManifold(self):
            ret=b2WorldManifold()
            self.__GetWorldManifold_internal(ret)
            return ret

        # Read-write properties
        enabled = property(__IsEnabled, __SetEnabled)

        # Read-only
        next = property(__GetNext, None)
        fixtureB = property(__GetFixtureB, None)
        fixtureA = property(__GetFixtureA, None)
        manifold = property(__GetManifold, None)
        childIndexA = property(__GetChildIndexA, None)
        childIndexB = property(__GetChildIndexB, None)
        worldManifold = property(__GetWorldManifold, None)
        touching = property(__IsTouching, None)
        friction = property(__GetFriction, __SetFriction)
        restitution = property(__GetRestitution, __SetRestitution)
    %}
}

%rename(__GetNext) b2Contact::GetNext;
%rename(__GetFixtureB) b2Contact::GetFixtureB;
%rename(__GetFixtureA) b2Contact::GetFixtureA;
%rename(__GetChildIndexA) b2Contact::GetChildIndexA;
%rename(__GetChildIndexB) b2Contact::GetChildIndexB;
%rename(__GetManifold) b2Contact::GetManifold;
%rename(__GetWorldManifold_internal) b2Contact::GetWorldManifold;
%rename(__IsEnabled) b2Contact::IsEnabled;
%rename(__SetEnabled) b2Contact::SetEnabled;
%rename(__IsTouching) b2Contact::IsTouching;
%rename(__GetFriction) b2Contact::GetFriction;
%rename(__SetFriction) b2Contact::SetFriction;
%rename(__GetRestitution) b2Contact::GetRestitution;
%rename(__SetRestitution) b2Contact::SetRestitution;

/**** Create our own ContactPoint structure ****/
/* And allow kwargs for it */

%inline {
    class b2ContactPoint
    {
    public:
        b2ContactPoint() : fixtureA(NULL), fixtureB(NULL), state(b2_nullState) {
            normal.SetZero();
            position.SetZero();
        }
        ~b2ContactPoint() {}

        b2Fixture* fixtureA;
        b2Fixture* fixtureB;
        b2Vec2 normal;
        b2Vec2 position;
        b2PointState state;
    };
}


/**** Replace b2TimeOfImpact ****/
%inline %{
    b2TOIOutput* _b2TimeOfImpact(b2Shape* shapeA, int idxA, b2Shape* shapeB, int idxB, b2Sweep& sweepA, b2Sweep& sweepB, float32 tMax) {
        b2TOIInput input;
        b2TOIOutput* out=new b2TOIOutput;

        input.proxyA.Set(shapeA, idxA);
        input.proxyB.Set(shapeB, idxB);
        input.sweepA = sweepA;
        input.sweepB = sweepB;
        input.tMax = tMax;

        b2TimeOfImpact(out, &input);
        return out;
    }
    b2TOIOutput* _b2TimeOfImpact(b2TOIInput* input) {
        b2TOIOutput* out=new b2TOIOutput;
        b2TimeOfImpact(out, input);
        return out;
    }
%}

%pythoncode %{
    def b2TimeOfImpact(*args, **kwargs):
        """
        Compute the upper bound on time before two shapes penetrate. Time is represented as
        a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate,
        non-tunneling collision. If you change the time interval, you should call this function
        again.
        Note: use b2Distance to compute the contact point and normal at the time of impact.
        
        Can be called one of several ways:
        + b2TimeOfImpact(b2TOIInput) # utilizes the b2TOIInput structure, where you define your own proxies

        Or utilizing kwargs:
        + b2TimeOfImpact(shapeA=a, shapeB=b, idxA=0, idxB=0, sweepA=sa, sweepB=sb, tMax=t)
        Where idxA and idxB are optional and used only if the shapes are loops (they indicate which section to use.)
        sweep[A,B] are of type b2Sweep.

        Returns a tuple in the form:
        (output state, time of impact)

        Where output state is in b2TOIOutput.[
                e_unknown, 
                e_failed,
                e_overlapped,
                e_touching,
                e_separated ]
        """
        if len(args) == 5 or len(args) == 1:
            out=_b2TimeOfImpact(*args)
        elif kwargs: # use kwargs
            shapeA = kwargs['shapeA']
            shapeB = kwargs['shapeB']
            sweepA = kwargs['sweepA']
            sweepB = kwargs['sweepB']
            tMax = kwargs['tMax']
            if 'idxA' in kwargs:
                idxA = kwargs['idxA']
            else:
                idxA=0
            if 'idxB' in kwargs:
                idxB = kwargs['idxB']
            else:
                idxB=0
            out=_b2TimeOfImpact(shapeA, idxA, shapeB, idxB, sweepA, sweepB, tMax)
        else:
            raise ValueError('Expected arguments for b2TimeOfImpact or kwargs')

        return (out.state, out.t)
%}

%newobject _b2TimeOfImpact;
%ignore b2TimeOfImpact;

