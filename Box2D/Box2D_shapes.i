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

/**** Shape ****/
%extend b2Shape {
public:
    long __hash__() { return (long)self; }
    %pythoncode %{
        __eq__ = b2ShapeCompare
        __ne__ = lambda self,other: not b2ShapeCompare(self,other)
        # Read-only
        type = property(__GetType, None)

        @property
        def childCount(self):
            """
            Get the number of child primitives.
            """
            return self.__GetChildCount()
       
        def getAABB(self, transform, childIndex):
            """
            Given a transform, compute the associated axis aligned bounding box for a child shape.
            """
            if childIndex >= self.childCount:
                raise ValueError('Child index should be at most childCount=%d' % self.childCount)
            aabb=b2AABB()
            self.__ComputeAABB(aabb, transform, childIndex)
            return aabb

        def getMass(self, density):
            """
            Compute the mass properties of this shape using its dimensions and density.
            The inertia tensor is computed about the local origin.
            """
            m=b2MassData()
            self.__ComputeMass(m, density)
            return m
    
    %}
}

%ignore b2Shape::m_type;
%ignore b2Shape::Clone;
%rename(radius) b2Shape::m_radius;
%rename(__GetChildCount) b2Shape::GetChildCount;
%rename(__GetType) b2Shape::GetType;
%rename(__ComputeAABB) b2Shape::ComputeAABB;
%rename(__ComputeMass) b2Shape::ComputeMass;

/**** CircleShape ****/
%extend b2CircleShape {
public:
    %pythoncode %{
    %}
}

%rename (pos) b2CircleShape::m_p;
%ignore b2CircleShape::GetVertexCount;
%ignore b2CircleShape::GetVertex;
%ignore b2CircleShape::GetSupport;
%ignore b2CircleShape::GetSupportVertex;

/**** PolygonShape ****/
%extend b2PolygonShape {
public:
    PyObject* __get_vertices() {
        PyObject* ret=PyList_New($self->m_vertexCount);
        PyObject* vertex;
        for (int i=0; i < $self->m_vertexCount; i++) {
            vertex = PyTuple_New(2);
            PyTuple_SetItem(vertex, 0, SWIG_From_double((float32)$self->m_vertices[i].x));
            PyTuple_SetItem(vertex, 1, SWIG_From_double((float32)$self->m_vertices[i].y));
            PyList_SetItem(ret, i, vertex);
        }
        return ret;
    }

    PyObject* __get_normals() {
        PyObject* ret=PyList_New($self->m_vertexCount);
        PyObject* vertex;
        for (int i=0; i < $self->m_vertexCount; i++) {
            vertex = PyTuple_New(2);
            PyTuple_SetItem(vertex, 0, SWIG_From_double((float32)$self->m_normals[i].x));
            PyTuple_SetItem(vertex, 1, SWIG_From_double((float32)$self->m_normals[i].y));
            PyList_SetItem(ret, i, vertex);
        }
        return ret;
    }

    %pythoncode %{
    def __repr__(self):
        return "b2PolygonShape(vertices: %s)" % (self.vertices)
    def __clear_vertices(self):
        self.vertexCount=0
        for i in range(0, b2_maxPolygonVertices):
            self.set_vertex(i, 0, 0)
    def __set_vertices(self, values):
        if not values:
            self.__clear_vertices()
        else:
            if len(values) < 2 or len(values) > b2_maxPolygonVertices:
                raise ValueError('Expected tuple or list of length >= 2 and less than b2_maxPolygonVertices=%d, got length %d.' %
                                     (b2_maxPolygonVertices, len(values)))
            for i,value in enumerate(values):
                if isinstance(value, (tuple, list, b2Vec2)):
                    if len(value) != 2:
                        raise ValueError('Expected tuple or list of length 2, got length %d' % len(value))
                    self.set_vertex(i, *value)
                else:
                    raise ValueError('Expected tuple, list, or b2Vec2, got %s' % type(value))
                self.vertexCount=i+1 # follow along in case of an exception to indicate valid number set
            if self.valid:
                self.__set_vertices_internal() # calculates normals, centroid, etc.

    def __iter__(self):
        """
        Iterates over the vertices in the polygon
        """
        for v in self.vertices:
            yield v

    def __IsValid(self):
        return b2CheckPolygon(self)

    valid = property(__IsValid, None, doc="Checks the polygon to see if it can be properly created. Raises ValueError for invalid shapes.")
    vertices = property(__get_vertices, __set_vertices, doc="All of the vertices as a list of tuples [ (x1,y1), (x2,y2) ... (xN,yN) ]")
    normals = property(__get_normals, None, doc="All of the normals as a list of tuples [ (x1,y1), (x2,y2) ... (xN,yN) ]")
    box = property(None, lambda self, value: self.SetAsBox(*value), doc="Property replacement for running SetAsBox (Write-only)")
    %}

    const b2Vec2* __get_vertex(uint16 vnum) {
        if (vnum >= b2_maxPolygonVertices) return NULL;
        return &( $self->m_vertices[vnum] );
    }
    const b2Vec2* __get_normal(uint16 vnum) {
        if (vnum >= b2_maxPolygonVertices) return NULL;
        return &( $self->m_normals[vnum] );
    }
    void set_vertex(uint16 vnum, b2Vec2& value) {
        if (vnum < b2_maxPolygonVertices)
            $self->m_vertices[vnum].Set(value.x, value.y);
    }
    void set_vertex(uint16 vnum, float32 x, float32 y) {
        if (vnum < b2_maxPolygonVertices)
            $self->m_vertices[vnum].Set(x, y);
    }
    void __set_vertices_internal() {
        $self->Set($self->m_vertices, $self->m_vertexCount);
    }
}
%rename (centroid) b2PolygonShape::m_centroid;
%rename (vertexCount) b2PolygonShape::m_vertexCount;
%rename (__set_vertices_internal) b2PolygonShape::Set;
%ignore b2PolygonShape::m_normals;
%ignore b2PolygonShape::m_vertices;
%ignore b2PolygonShape::GetVertex;
%ignore b2PolygonShape::GetVertexCount;
%ignore b2PolygonShape::vertices;
%ignore b2PolygonShape::GetVertices;
%ignore b2PolygonShape::GetNormals;


/**** LoopShape ****/
%include "carrays.i"
%array_class(b2Vec2, _b2Vec2Array);

%extend b2LoopShape {
public:
    PyObject* __get_vertices() {
        int32 count=$self->GetCount();
        PyObject* ret=PyList_New(count);
        PyObject* vertex;
        for (int i=0; i < count; i++) {
            vertex = PyTuple_New(2);
            PyTuple_SetItem(vertex, 0, SWIG_From_double((float32)$self->GetVertex(i).x));
            PyTuple_SetItem(vertex, 1, SWIG_From_double((float32)$self->GetVertex(i).y));
            PyList_SetItem(ret, i, vertex);
        }
        return ret;
    }

    %pythoncode %{
    def __repr__(self):
        return "b2LoopShape(vertices: %s)" % (self.vertices)

    def getChildEdge(self, index):
        if childIndex >= self.childCount:
            raise ValueError('Child index should be at most childCount=%d' % self.childCount)

        edge=b2EdgeShape()
        self.__GetChildEdge(edge, index)
        return edge

    @property
    def edges(self):
        return [self.getChildEdge(i) for i in range(self.childCount)]

    @property
    def vertexCount(self):
        return self.__GetCount()

    def __get_vertices(self):
        """Returns all of the vertices as a list of tuples [ (x1,y1), (x2,y2) ... (xN,yN) ]"""
        return [ (self.__get_vertex(i).x, self.__get_vertex(i).y )
                         for i in range(0, self.vertexCount)]

    def __iter__(self):
        """
        Iterates over the vertices in the Loop
        """
        for v in self.vertices:
            yield v

    def __set_vertices(self, values):
        if not values or not isinstance(values, (list, tuple)) or (len(values) < 2):
            raise ValueError('Expected tuple or list of length >= 2.')

        for i,value in enumerate(values):
            if isinstance(value, (tuple, list)):
                if len(value) != 2:
                    raise ValueError('Expected tuple or list of length 2, got length %d' % len(value))
                for j in value:
                     if not isinstance(j, (int, float)):
                        raise ValueError('Expected int or float values, got %s' % (type(j)))
            elif isinstance(value, b2Vec2):
                pass
            else:
                raise ValueError('Expected tuple, list, or b2Vec2, got %s' % type(value))
            
        vecs=_b2Vec2Array(len(values))
        for i, value in enumerate(values):
            if isinstance(value, b2Vec2):
                vecs[i]=value
            else:
                vecs[i]=b2Vec2(value)
        self.__bypass_create(vecs, len(values))
        
    vertices=property(__get_vertices, __set_vertices)
    %}

    void __bypass_create(_b2Vec2Array* v, int c) {
        if (v)
            $self->Create(v, c);
    }

    const b2Vec2* __get_vertex(uint16 vnum) {
        if (vnum >= $self->GetCount()) return NULL;
        return &($self->GetVertex(vnum));
    }
}
%rename (__GetVertices) b2LoopShape::GetVertices;
%rename (__GetVertex) b2LoopShape::GetVertex;
%rename (__GetCount) b2LoopShape::GetCount;
%rename (__GetChildEdge) b2LoopShape::GetChildEdge;
%ignore b2LoopShape::m_vertices;
%ignore b2LoopShape::m_count;
%ignore b2LoopShape::Create;

/**** EdgeShape ****/
%extend b2EdgeShape {
public:
    %pythoncode %{
    def __repr__(self):
        return "b2EdgeShape(vertices: %s)" % (self.vertices)

    @property
    def all_vertices(self):
        """Returns all of the vertices as a list of tuples [ (x0,y0), (x1,y1), (x2,y2) (x3,y3) ]
        Note that the validity of vertices 0 and 4 depend on whether or not
        hasVertex0 and hasVertex3 are set.
        """
        return [tuple(self.vertex0), tuple(self.vertex1), tuple(self.vertex2), tuple(self.vertex3)]

    def __get_vertices(self):
        """Returns the basic vertices as a list of tuples [ (x1,y1), (x2,y2) ]
        To include the supporting vertices, see 'all_vertices'

        If you want to set vertex3 but not vertex0, pass in None for vertex0.
        """
        return [tuple(self.vertex1), tuple(self.vertex2)]

    def __set_vertices(self, vertices):
        if len(vertices)==2:
            self.vertex1, self.vertex2=vertices
            self.hasVertex0=False
            self.hasVertex3=False
        elif len(vertices)==3:
            self.vertex0, self.vertex1, self.vertex2=vertices
            self.hasVertex0=(vertices[0] != None)
            self.hasVertex3=False
        elif len(vertices)==4:
            self.vertex0, self.vertex1, self.vertex2, self.vertex3=vertices
            self.hasVertex0=(vertices[0] != None)
            self.hasVertex3=True
        else:
            raise ValueError('Expected from 2 to 4 vertices.')

    @property
    def vertexCount(self):
        """
        Returns the number of valid vertices (as in, it counts whether or not 
        hasVertex0 or hasVertex3 are set)
        """
        if self.hasVertex0 and self.hasVertex3:
            return 4
        elif self.hasVertex0 or self.hasVertex3:
            return 3
        else:
            return 2

    def __iter__(self):
        """
        Iterates over the vertices in the Edge
        """
        for v in self.vertices:
            yield v

    vertices=property(__get_vertices, __set_vertices)
    %}
}
%rename(radius) b2EdgeShape::m_radius;
%rename(vertex0) b2EdgeShape::m_vertex0;
%rename(vertex1) b2EdgeShape::m_vertex1;
%rename(vertex2) b2EdgeShape::m_vertex2;
%rename(vertex3) b2EdgeShape::m_vertex3;
%rename(hasVertex0) b2EdgeShape::m_hasVertex0;
%rename(hasVertex3) b2EdgeShape::m_hasVertex3;
%rename(__Set) b2EdgeShape::Set;

