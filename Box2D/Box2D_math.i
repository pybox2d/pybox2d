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

//These operators do not work unless explicitly defined like this 
%ignore operator  + (const b2Vec2& a, const b2Vec2& b);
%ignore operator  + (const b2Mat22& A, const b2Mat22& B);
%ignore operator  - (const b2Vec2& a, const b2Vec2& b);
%ignore operator  * (float32 s, const b2Vec2& a);
%ignore operator == (const b2Vec2& a, const b2Vec2& b);

%ignore operator * (float32 s, const b2Vec3& a);
%ignore operator + (const b2Vec3& a, const b2Vec3& b);
%ignore operator - (const b2Vec3& a, const b2Vec3& b);

//Since Python (apparently) requires __imul__ to return self,
//these void operators will not do. So, rename them, then call them
//with Python code, and return self. (see further down in b2Vec2)
%rename(__add_vector) b2Vec2::operator += (const b2Vec2& v);
%rename(__sub_vector) b2Vec2::operator -= (const b2Vec2& v);
%rename(__mul_float ) b2Vec2::operator *= (float32 a);
%rename(__add_vector) b2Vec3::operator += (const b2Vec3& v);
%rename(__sub_vector) b2Vec3::operator -= (const b2Vec3& v);
%rename(__mul_float ) b2Vec3::operator *= (float32 a);

/**** Vector classes ****/
%extend b2Vec2 {
public:
    b2Vec2(b2Vec2& other) {
        return new b2Vec2(other.x, other.y);
    }

    %pythoncode %{
    __iter__ = lambda self: iter( (self.x, self.y) )
    __eq__ = lambda self, other: self.__equ(other)
    __ne__ = lambda self,other: not self.__equ(other)
    def __repr__(self):
        return "b2Vec2(%g,%g)" % (self.x, self.y)
    def __len__(self):
        return 2
    def __neg__(self):
        return b2Vec2(-self.x, -self.y)
    def __copy__(self):
        return b2Vec2(self.x, self.y)
    def copy(self):
        """
        Return a copy of the vector.
        Remember that the following:
            a = b2Vec2()
            b = a
        Does not copy the vector itself, but b now refers to a.
        """
        return b2Vec2(self.x, self.y)
    def __iadd__(self, other):
        self.__add_vector(other)
        return self
    def __isub__(self, other):
        self.__sub_vector(other)
        return self
    def __imul__(self, a):
        self.__mul_float(a)
        return self
    def __itruediv__(self, a):
        self.__div_float(a)
        return self
    def __idiv__(self, a):
        self.__div_float(a)
        return self
    def __set(self, x, y):
        self.x = x
        self.y = y
    def __nonzero__(self):
        return self.x!=0.0 or self.y!=0.0

    tuple = property(lambda self: (self.x, self.y), lambda self, value: self.__set(*value))
    length = property(__Length, None)
    lengthSquared = property(__LengthSquared, None)
    valid = property(__IsValid, None)
    skew = property(__Skew, None) 

    %}
    float32 cross(b2Vec2& other) {
        return $self->x * other.y - $self->y * other.x;
    }
    b2Vec2 cross(float32 s) {
        return b2Vec2(s * $self->y, -s * $self->x);
    }

    float32 __getitem__(int i) {
        if (i==0) 
            return $self->x;
        else if (i==1) 
            return $self->y;
        PyErr_SetString(PyExc_IndexError, "Index must be in (0,1)");
        return 0.0f;
    }
    void __setitem__(int i, float32 value) {
        if (i==0) 
            $self->x=value;
        else if (i==1) 
            $self->y=value;
        else
            PyErr_SetString(PyExc_IndexError, "Index must be in (0,1)");
    }
    bool __equ(b2Vec2& other) {
        return ($self->x == other.x && $self->y == other.y);
    }
    float32 dot(b2Vec2& other) {
        return $self->x * other.x + $self->y * other.y;
    }
    b2Vec2 __truediv__(float32 a) { //python 3k
        return b2Vec2($self->x / a, $self->y / a);
    }
    b2Vec2 __div__(float32 a) {
        return b2Vec2($self->x / a, $self->y / a);
    }
    b2Vec2 __mul__(float32 a) {
        return b2Vec2($self->x * a, $self->y * a);
    }
    b2Vec2 __add__(b2Vec2* other) {
        return b2Vec2($self->x + other->x, $self->y + other->y);
    }
    b2Vec2 __sub__(b2Vec2* other) {
        return b2Vec2($self->x - other->x, $self->y - other->y);
    }

    b2Vec2 __rmul__(float32 a) {
        return b2Vec2($self->x * a, $self->y * a);
    }
    b2Vec2 __rdiv__(float32 a) {
        return b2Vec2($self->x / a, $self->y / a);
    }
    void __div_float(float32 a) {
        $self->x /= a;
        $self->y /= a;
    }
}

%rename (__Length) b2Vec2::Length;
%rename (__LengthSquared) b2Vec2::LengthSquared;
%rename (__IsValid) b2Vec2::IsValid;
%rename (__Skew) b2Vec2::Skew;

%extend b2Vec3 {
public:
    b2Vec3(b2Vec3& other) {
        return new b2Vec3(other.x, other.y, other.z);
    }

    b2Vec3(b2Vec2& other) {
        return new b2Vec3(other.x, other.y, 0.0f);
    }

    %pythoncode %{
    __iter__ = lambda self: iter( (self.x, self.y, self.z) )
    __eq__ = lambda self, other: (self.x == other.x and self.y == other.y and self.z == other.z)
    __ne__ = lambda self,other: (self.x != other.x or self.y != other.y or self.z != other.z)
    def __repr__(self):
        return "b2Vec3(%g,%g,%g)" % (self.x, self.y, self.z)
    def __len__(self):
        return 3
    def __copy__(self):
        return b2Vec3(self.x, self.y, self.z)
    def __neg__(self):
        return b2Vec3(-self.x, -self.y, -self.z)
    def copy(self):
        """
        Return a copy of the vector.
        Remember that the following:
            a = b2Vec3()
            b = a
        Does not copy the vector itself, but b now refers to a.
        """
        return b2Vec3(self.x, self.y, self.z)
    def __iadd__(self, other):
        self.__add_vector(other)
        return self
    def __isub__(self, other):
        self.__sub_vector(other)
        return self
    def __imul__(self, a):
        self.__mul_float(a)
        return self
    def __itruediv__(self, a):
        self.__div_float(a)
        return self
    def __idiv__(self, a):
        self.__div_float(a)
        return self
    def dot(self, v):
        """
        Dot product with v (list/tuple or b2Vec3)
        """
        if isinstance(v, (list, tuple)):
            return self.x*v[0] + self.y*v[1] + self.z*v[2]
        else:
            return self.x*v.x + self.y*v.y + self.z*v.z
    def __set(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
    def __nonzero__(self):
        return self.x!=0.0 or self.y!=0.0 or self.z!=0.0

    tuple = property(lambda self: (self.x, self.y, self.z), lambda self, value: self.__set(*value))
    length = property(_Box2D.b2Vec3___Length, None)
    lengthSquared = property(_Box2D.b2Vec3___LengthSquared, None)
    valid = property(_Box2D.b2Vec3___IsValid, None)

    %}

    b2Vec3 cross(b2Vec3& b) {
        return b2Vec3($self->y * b.z - $self->z * b.y, $self->z * b.x - $self->x * b.z, $self->x * b.y - $self->y * b.x);
    }
    float32 __getitem__(int i) {
        if (i==0) 
            return $self->x;
        else if (i==1) 
            return $self->y;
        else if (i==2) 
            return $self->z;
        PyErr_SetString(PyExc_IndexError, "Index must be in (0,1,2)");
        return 0.0f;
    }
    void __setitem__(int i, float32 value) {
        if (i==0) 
            $self->x=value;
        else if (i==1) 
            $self->y=value;
        else if (i==2) 
            $self->z=value;
        else
            PyErr_SetString(PyExc_IndexError, "Index must be in (0,1,2)");
    }
    bool __IsValid() {
        return b2IsValid($self->x) && b2IsValid($self->y) && b2IsValid($self->z);
    }
    float32 __Length() {
        return b2Sqrt($self->x * $self->x + $self->y * $self->y + $self->z * $self->z);
    }
    float32 __LengthSquared() {
        return ($self->x * $self->x + $self->y * $self->y + $self->z * $self->z);
    }
    b2Vec3 __truediv__(float32 a) {
        return b2Vec3($self->x / a, $self->y / a, $self->z / a);
    }
    b2Vec3 __div__(float32 a) {
        return b2Vec3($self->x / a, $self->y / a, $self->z / a);
    }
    b2Vec3 __mul__(float32 a) {
        return b2Vec3($self->x * a, $self->y * a, $self->z * a);
    }
    b2Vec3 __add__(b2Vec3* other) {
        return b2Vec3($self->x + other->x, $self->y + other->y, $self->z + other->z);
    }
    b2Vec3 __sub__(b2Vec3* other) {
        return b2Vec3($self->x - other->x, $self->y - other->y, $self->z - other->z);
    }

    b2Vec3 __rmul__(float32 a) {
        return b2Vec3($self->x * a, $self->y * a, $self->z * a);
    }
    b2Vec3 __rdiv__(float32 a) {
        return b2Vec3($self->x / a, $self->y / a, self->z / a);
    }
    void __div_float(float32 a) {
        $self->x /= a;
        $self->y /= a;
        $self->z /= a;
    }
}

/**** Mat22 ****/
%extend b2Mat22 {
public:
    %pythoncode %{
        # Read-only
        inverse = property(__GetInverse, None)
        angle = property(__GetAngle, __SetAngle)
    %}
    b2Vec2 __mul__(b2Vec2* v) {
        return b2Vec2($self->col1.x * v->x + $self->col2.x * v->y, $self->col1.y * v->x + $self->col2.y * v->y);
    }
    b2Mat22 __mul__(b2Mat22* m) {
        return b2Mat22(b2Mul(*($self), m->col1), b2Mul(*($self), m->col2));
    }
    b2Mat22 __add__(b2Mat22* m) {
        return b2Mat22($self->col1 + m->col1, $self->col2 + m->col2);
    }
    b2Mat22 __sub__(b2Mat22* m) {
        return b2Mat22($self->col1 - m->col1, $self->col2 - m->col2);
    }
    void __iadd(b2Mat22* m) {
        $self->col1 += m->col1;
        $self->col2 += m->col2;
    }
    void __isub(b2Mat22* m) {
        $self->col1 -= m->col1;
        $self->col2 -= m->col2;
    }
}

%rename(__SetAngle) b2Mat22::Set;
%rename(__GetInverse) b2Mat22::GetInverse;
%rename(__GetAngle) b2Mat22::GetAngle;

%feature("shadow") b2Mat22::__iadd__ {
    def __iadd__(self, other):
        self.__iadd(other)
        return self
}
%feature("shadow") b2Mat22::__isub__ {
    def __iadd__(self, other):
        self.__iadd(other)
        return self
}

/**** Mat33 ****/
%extend b2Mat33 {
public:
    %pythoncode %{
    %}
    b2Vec3 __mul__(b2Vec3& v) {
        return v.x * $self->col1 + v.y * $self->col2 + v.z * $self->col3;
    }
    b2Mat33 __add__(b2Mat33* other) {
        return b2Mat33($self->col1 + other->col1, $self->col2 + other->col2, $self->col3 + other->col3);
    }
    b2Mat33 __sub__(b2Mat33* other) {
        return b2Mat33($self->col1 - other->col1, $self->col2 - other->col2, $self->col3 - other->col3);
    }
    void __iadd(b2Mat33* other) {
        $self->col1 += other->col1;
        $self->col2 += other->col2;
        $self->col3 += other->col3;
    }
    void __isub(b2Mat33* other) {
        $self->col1 -= other->col1;
        $self->col2 -= other->col2;
        $self->col3 -= other->col3;
    }
}

%feature("shadow") b2Mat33::__iadd__ {
    def __iadd__(self, other):
        self.__iadd(other)
        return self
}
%feature("shadow") b2Mat33::__isub__ {
    def __iadd__(self, other):
        self.__iadd(other)
        return self
}

%rename(__GetAngle) b2Mat33::GetAngle;
%rename(set) b2Mat33::Set;

/**** Transform ****/
%extend b2Transform {
public:
    %pythoncode %{
        def __SetAngle(self, angle):
            self.R.angle=angle

        # Read-only
        angle = property(__GetAngle, __SetAngle) 
    %}
    b2Vec2 __mul__(b2Vec2& v) {
        return b2Vec2($self->position.x + $self->R.col1.x*v.x + $self->R.col2.x*v.y, 
                $self->position.y + $self->R.col1.y*v.x + $self->R.col2.y*v.y);
    }
}

%rename(__GetAngle) b2Transform::GetAngle;

/**** AABB ****/
%rename(__contains__) b2AABB::Contains;
%rename(__IsValid) b2AABB::IsValid;
%rename(__GetExtents) b2AABB::GetExtents;
%rename(__GetCenter) b2AABB::GetCenter;
%rename(__GetPerimeter) b2AABB::GetPerimeter;

%include "Box2D/Collision/b2Collision.h"

%extend b2AABB {
public:
    %pythoncode %{
        # Read-only
        valid = property(__IsValid, None)
        extents = property(__GetExtents, None)
        center = property(__GetCenter, None)
        perimeter = property(__GetPerimeter, None)

    %}

    bool __contains__(const b2Vec2& point) {
        //If point is in aabb (including a small buffer around it), return true.
        if (point.x < ($self->upperBound.x + b2_epsilon) &&
            point.x > ($self->lowerBound.x - b2_epsilon) &&
            point.y < ($self->upperBound.y + b2_epsilon) &&
            point.y > ($self->lowerBound.y - b2_epsilon))
                return true;
        return false;
    }
    
    bool overlaps(const b2AABB& aabb2) {
        //If aabb and aabb2 overlap, return true. (modified from b2BroadPhase::InRange)
        b2Vec2 d = b2Max($self->lowerBound - aabb2.upperBound, aabb2.lowerBound - $self->upperBound);
        return b2Max(d.x, d.y) < 0.0f;
    }

}



