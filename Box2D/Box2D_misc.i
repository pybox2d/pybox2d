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

/* ---- miscellaneous classes ---- */
/**** Color ****/
%extend b2Color {
public:
    b2Color(b2Color& other) {
        return new b2Color(other.r, other.g, other.b);
    }
    PyObject* __get_bytes() {
        PyObject* ret=PyList_New(3);
        PyList_SetItem(ret, 0, SWIG_From_int((int)(255*$self->r)));
        PyList_SetItem(ret, 1, SWIG_From_int((int)(255*$self->g)));
        PyList_SetItem(ret, 2, SWIG_From_int((int)(255*$self->b)));
        return ret;
    }

    %pythoncode %{
    __iter__ = lambda self: iter((self.r, self.g, self.b)) 
    __eq__ = lambda self, other: self.__equ(other)
    __ne__ = lambda self,other: not self.__equ(other)
    def __repr__(self):
        return "b2Color(%g,%g,%g)" % (self.r, self.g, self.b)
    def __len__(self):
        return 3
    def __copy__(self):
        return b2Color(self.r, self.g, self.b)
    def copy(self):
        return b2Color(self.r, self.g, self.b)
    def __set_bytes(self, value):
        if len(value) != 3:
            raise ValueError('Expected length 3 list')
        self.r, self.g, self.b = value[0]/255, value[1]/255, value[2]/255
    def __set_tuple(self, value):
        if len(value) != 3:
            raise ValueError('Expected length 3 list')
        self.r, self.g, self.b = value[0], value[1], value[2]
    def __nonzero__(self):
        return self.r!=0.0 or self.g!=0.0 or self.b!=0.0

    list  = property(lambda self: list(self), __set_tuple)
    bytes = property(__get_bytes, __set_bytes)
    %}

    float32 __getitem__(int i) {
        if (i==0) 
            return $self->r;
        else if (i==1) 
            return $self->g;
        else if (i==2) 
            return $self->b;

        PyErr_SetString(PyExc_IndexError, "Index must be in (0,1,2)");
        return 0.0f;
    }
    void __setitem__(int i, float32 value) {
        if (i==0) 
            $self->r=value;
        else if (i==1) 
            $self->g=value;
        else if (i==2) 
            $self->b=value;
        else
            PyErr_SetString(PyExc_IndexError, "Index must be in (0,1,2)");
    }
    b2Color __truediv__(float32 a) {
        return b2Color($self->r / a, $self->g / a, $self->b / a);
    }
    b2Color __add__(b2Color& o) {
        return b2Color($self->r + o.r, $self->g + o.g, $self->b + o.b);
    }
    b2Color __sub__(b2Color& o) {
        return b2Color($self->r - o.r, $self->g - o.g, $self->b - o.b);
    }
    b2Color __div__(float32 a) {
        return b2Color($self->r / a, $self->g / a, $self->b / a);
    }
    b2Color __rmul__(float32 a) {
        return b2Color($self->r * a, $self->g * a, $self->b * a);
    }
    b2Color __mul__(float32 a) {
        return b2Color($self->r * a, $self->g * a, $self->b * a);
    }
    void __isub(b2Color& o) {
        $self->r -= o.r;
        $self->g -= o.g;
        $self->b -= o.b;
    }
    void __itruediv(b2Color& o) {
        $self->r /= o.r;
        $self->g /= o.g;
        $self->b /= o.b;
    }
    void __idiv(b2Color& o) {
        $self->r /= o.r;
        $self->g /= o.g;
        $self->b /= o.b;
    }
    void __imul(b2Color& o) {
        $self->r *= o.r;
        $self->g *= o.g;
        $self->b *= o.b;
    }
    void __iadd(b2Color& o) {
        $self->r += o.r;
        $self->g += o.g;
        $self->b += o.b;
    }
    bool __equ(b2Color& b) {
        return ($self->r == b.r && $self->g==b.g && $self->b==b.b);
    }
     
}

%feature("shadow") b2Color::__iadd {
    def __iadd__(self, other):
        self.__iadd(other)
        return self
}
%feature("shadow") b2Color::__isub {
    def __isub__(self, other):
        self.__isub(other)
        return self
}
%feature("shadow") b2Color::__imul {
    def __imul__(self, other):
        self.__imul(other)
        return self
}
%feature("shadow") b2Color::__idiv {
    def __idiv__(self, other):
        self.__idiv(other)
        return self
}
%feature("shadow") b2Color::__itruediv {
    def __itruediv__(self, other):
        self.__itruediv(other)
        return self
}


/**** DistanceProxy ****/
%extend b2DistanceProxy {
public:
    %pythoncode %{
        def __get_vertices(self):
            """Returns all of the vertices as a list of tuples [ (x1,y1), (x2,y2) ... (xN,yN) ]"""
            return [ (self.__get_vertex(i).x, self.__get_vertex(i).y )
                             for i in range(0, self.__get_vertex_count())]

        shape = property(None, __Set, doc='The shape to be used. (read-only)')
        vertices = property(__get_vertices, None)
    %}
}

/* Shouldn't need access to these, only by setting the shape. */
%rename (__Set) b2DistanceProxy::Set;
%rename (__get_vertex) b2DistanceProxy::GetVertex;
%rename (__get_vertex_count) b2DistanceProxy::GetVertexCount;
%ignore b2DistanceProxy::m_count;
%ignore b2DistanceProxy::m_vertices;
%ignore b2DistanceProxy::m_radius;

/**** Version ****/
%extend b2Version {
public:
    %pythoncode %{
        def __repr__(self):
            return "b2Version(%s.%s.%s)" % (self.major, self.minor, self.revision)
    %}
}

/*** Replace b2Distance ***/
%inline %{
    b2DistanceOutput* _b2Distance(b2Shape* shapeA, int idxA, b2Shape* shapeB, int idxB, b2Transform& transformA, b2Transform& transformB, bool useRadii=true) {
        if (!shapeA || !shapeB)
            return NULL;

        b2DistanceInput input;
        b2DistanceOutput* out=new b2DistanceOutput;
        b2SimplexCache cache;

        input.proxyA.Set(shapeA, idxA);
        input.proxyB.Set(shapeB, idxB);
        input.transformA = transformA;
        input.transformB = transformB;
        input.useRadii = useRadii;

        cache.count=0;
        b2Distance(out, &cache, &input);
        return out;
    }
    b2DistanceOutput* _b2Distance(b2DistanceInput* input) {
        if (!input)
            return NULL;

        b2DistanceOutput* out=new b2DistanceOutput;
        b2SimplexCache cache;
        cache.count=0;
        b2Distance(out, &cache, input);
        return out;
    }
%}

%pythoncode %{
    def b2Distance(*args, **kwargs):
        """
        Compute the closest points between two shapes.

        Can be called one of two ways:
        + b2Distance(b2DistanceInput) # utilizes the b2DistanceInput structure, where you define your own proxies

        Or utilizing kwargs:
        + b2Distance(shapeA=a, shapeB=b, transformA=sa, transformB=sb [, useRadii=True])

        Returns a tuple in the form:
         ((pointAx, pointAy), (pointBx, pointBy), distance, iterations)
        """
        if len(args) in (1, 7):
            out=_b2Distance(*args)
        elif kwargs: # use kwargs
            shapeA = kwargs['shapeA']
            shapeB = kwargs['shapeB']
            transformA = kwargs['transformA']
            transformB = kwargs['transformB']
            if 'useRadii' in kwargs:
                useRadii = kwargs['useRadii']
            else:
                useRadii=True
            if 'idxA' in kwargs:
                idxA = kwargs['idxA']
            else:
                idxA=0
            if 'idxB' in kwargs:
                idxB = kwargs['idxB']
            else:
                idxB=0
            out=_b2Distance(shapeA, idxA, shapeB, idxB, transformA, transformB, useRadii)
        else:
            raise ValueError('Expected arguments for b2Distance or kwargs')

        return (tuple(out.pointA), tuple(out.pointB), out.distance, out.iterations)
%}

%newobject _b2Distance;
%ignore b2Distance;

/**** Sweep ****/
%extend b2Sweep {
public:
    b2Transform* GetTransform(float32 alpha) {
        b2Transform* out=new b2Transform;
        $self->GetTransform(out, alpha);
        return out;
    }
}

%newobject b2Sweep::GetTransform;

/**** BroadPhase ****/
//TODO: this needs to be fixed up
%extend b2BroadPhase {
public:
    %pythoncode %{
        proxyCount=property(__GetProxyCount, None)
        treeHeight=property(__GetTreeHeight, None)
        treeBalance=property(__GetTreeBalance, None)
        treeQuality=property(__GetTreeQuality, None)
    %}
}

%rename (__GetProxyCount) b2BroadPhase::GetProxyCount;
%rename (__GetTreeHeight) b2BroadPhase::GetTreeHeight;
%rename (__GetTreeBalance) b2BroadPhase::GetTreeBalance;
%rename (__GetTreeQuality) b2BroadPhase::GetTreeQuality;
%ignore b2BroadPhase::GetUserData;
