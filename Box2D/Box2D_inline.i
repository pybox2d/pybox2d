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

%typemap(out) bool b2CheckPolygon(b2PolygonShape*) {
    if (!$1) 
        SWIG_fail;
    else
        $result = SWIG_From_bool(static_cast< bool >($1));
}

%inline %{
    // Wrap toi settings
    extern int32 b2_toiMaxIters, b2_toiMaxRootIters;

    // Add support for == and != in Python for shapes, joints, and bodies.
    bool __jointeq(b2Joint* a, b2Joint* b) {
        return a==b;
    }
    bool __bodyeq(b2Body* a, b2Body* b) {
        return a==b;
    }
    bool __shapeeq(b2Shape* a, b2Shape* b) {
        return a==b;
    }
    bool __fixtureeq(b2Fixture* a, b2Fixture* b) {
        return a==b;
    }

    // Modified from the b2PolygonShape constructor
    // Should be as accurate as the original version
    b2Vec2 __b2ComputeCentroid(const b2Vec2* vs, int32 count) {
        b2Vec2 c; c.Set(0.0f, 0.0f);
        if (count < 3 || count > b2_maxPolygonVertices) {
            PyErr_SetString(PyExc_ValueError, "Vertex count must be >= 3 and <= b2_maxPolygonVertices");
            return c;
        }

        float32 area = 0.0f;

        // pRef is the reference point for forming triangles.
        // It's location doesn't change the result (except for rounding error).
        b2Vec2 pRef(0.0f, 0.0f);

        const float32 inv3 = 1.0f / 3.0f;

        for (int32 i = 0; i < count; ++i)
        {
            // Triangle vertices.
            b2Vec2 p1 = pRef;
            b2Vec2 p2 = vs[i];
            b2Vec2 p3 = i + 1 < count ? vs[i+1] : vs[0];

            b2Vec2 e1 = p2 - p1;
            b2Vec2 e2 = p3 - p1;

            float32 D = b2Cross(e1, e2);

            float32 triangleArea = 0.5f * D;
            area += triangleArea;

            // Area weighted centroid
            c += triangleArea * inv3 * (p1 + p2 + p3);
        }

        // Centroid
        if (area <= b2_epsilon) {
            PyErr_SetString(PyExc_ValueError, "ComputeCentroid: area <= FLT_EPSILON");
            return c;
        }

        c *= 1.0f / area;
        return c;
    }

    bool b2CheckVertices(b2Vec2* vertices, int32 count, bool additional_checks=true) {
        // Get the vertices transformed into the body frame.
        if (count < 2 || count > b2_maxPolygonVertices) {
            PyErr_SetString(PyExc_ValueError, "Vertex count must be >= 2 and <= b2_maxPolygonVertices");
            return false;
        }

        // Compute normals. Ensure the edges have non-zero length.
        b2Vec2 m_normals[b2_maxPolygonVertices];
        for (int32 i = 0; i < count; ++i)
        {
            int32 i1 = i;
            int32 i2 = i + 1 < count ? i + 1 : 0;
            b2Vec2 edge = vertices[i2] - vertices[i1];
            if (edge.LengthSquared() <= b2_epsilon * b2_epsilon) {
                PyErr_SetString(PyExc_ValueError, "edge.LengthSquared < FLT_EPSILON**2");
                return false;
            }
            
            m_normals[i] = b2Cross(edge, 1.0f);
            m_normals[i].Normalize();
        }

        // Compute the polygon centroid.
        b2Vec2 m_centroid = __b2ComputeCentroid(vertices, count);

        if (!additional_checks)
            return true;

        // Ensure the polygon is convex and the interior
        // is to the left of each edge.
        for (int32 i = 0; i < count; ++i)
        {
            int32 i1 = i;
            int32 i2 = i + 1 < count ? i + 1 : 0;
            b2Vec2 edge = vertices[i2] - vertices[i1];

            for (int32 j = 0; j < count; ++j)
            {
                // Don not check vertices on the current edge.
                if (j == i1 || j == i2)
                {
                    continue;
                }
                
                b2Vec2 r = vertices[j] - vertices[i1];

                // Your polygon is non-convex (it has an indentation) or
                // has colinear edges.
                float32 s = b2Cross(edge, r);
                if (s <= 0.0f) {
                    PyErr_SetString(PyExc_ValueError, "Your polygon is non-convex (it has an indentation) or has colinear edges.");
                    return false;
                }
            }
        }

        return true;
    }

    bool b2CheckPolygon(b2PolygonShape *shape, bool additional_checks=true) {
        if (!shape)
            return false;

        return b2CheckVertices(shape->m_vertices, shape->m_vertexCount, additional_checks);
    }

    /* As of Box2D SVN r191, these functions are no longer in b2Math.h,
       so re-add them here for backwards compatibility */
    #define RAND_LIMIT      32767      
    // Random number in range [-1,1]
    float32 b2Random()      
    {      
            float32 r = (float32)(rand() & (RAND_LIMIT));      
            r /= RAND_LIMIT;      
            r = 2.0f * r - 1.0f;      
            return r;      
    }      
          
    /// Random floating point number in range [lo, hi]      
    float32 b2Random(float32 lo, float32 hi)      
    {      
            float32 r = (float32)(rand() & (RAND_LIMIT));      
            r /= RAND_LIMIT;      
            r = (hi - lo) * r + lo;      
            return r;      
    }

%}

/* Additional supporting Python code */
%pythoncode %{
b2_epsilon = 1.192092896e-07

class _indexable_generator(list):
    def __init__(self, iter):
        list.__init__(self)
        self.iter=iter
        self.__full=False
    def __len__(self):
        self.__fill_list__()
        return list.len(self)
    def __iter__(self):
        for item in self.iter:
            self.append(item)
            yield item
        self.__full=True
    def __fill_list__(self):
        for item in self.iter:
            self.append(item)
        self.__full=True
    def __getitem__(self, i):
        """Support indexing positive/negative elements of the generator,
        but no slices. If you want those, use list(generator)"""
        if not self.__full:
            if i < 0:
                self.__fill_list__()
            elif i >= list.__len__(self):
                diff=i-list.__len__(self)+1
                for j in xrange(diff):
                    value=self.iter.next()
                    self.append(value)

        return list.__getitem__(self,i)

def _generator_from_linked_list(first):
    if first:
        one = first
        while one:
            yield one
            one = one.next

def _list_from_linked_list(first):
    if not first:
        return []

    one = first
    lst = []
    while one:
        lst.append(one)
        one = one.next

    # linked lists are stored in reverse order from creation order
    lst.reverse() 
    return lst

# Support using == on bodies, joints, and shapes
def b2ShapeCompare(a, b):
    if not isinstance(a, b2Shape) or not isinstance(b, b2Shape):
        return False
    return __shapeeq(a, b)
def b2BodyCompare(a, b):
    if not isinstance(a, b2Body) or not isinstance(b, b2Body):
        return False
    return __bodyeq(a, b)
def b2JointCompare(a, b):
    if not isinstance(a, b2Joint) or not isinstance(b, b2Joint):
        return False
    return __jointeq(a, b)
def b2FixtureCompare(a, b):
    if not isinstance(a, b2Fixture) or not isinstance(b, b2Fixture):
        return False
    return __fixtureeq(a, b)

%}

%feature("docstring") b2CheckPolygon "
    Checks the Polygon definition to see if upon creation it will cause an assertion.
    Raises ValueError if an assertion would be raised.

    b2PolygonDef* poly     - the polygon definition
    bool additional_checks - whether or not to run additional checks

    Additional checking: usually only in DEBUG mode on the C++ code.

    While shapes that pass this test can be created without assertions,
    they will ultimately create unexpected behavior. It's recommended
    to _not_ use any polygon that fails this test.
";

%feature("docstring") b2AABBOverlaps "Checks if two AABBs overlap, or if a point
lies in an AABB

b2AABBOverlaps(AABB1, [AABB2/point])
";
