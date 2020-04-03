/*
* C++ version Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
* Python version Copyright (c) 2010 kne / sirkne at gmail dot com
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

/**** Draw ****/
%extend b2Draw {
public:
    %pythoncode %{
        _flag_entries = [
            ['drawShapes', e_shapeBit],
            ['drawJoints', e_jointBit ],
            ['drawAABBs', e_aabbBit ],
            ['drawPairs', e_pairBit ],
            ['drawCOMs', e_centerOfMassBit ],
            ['convertVertices', e_convertVertices ],
        ]
        def _SetFlags(self, value):
            flags = 0
            for name_, mask in self._flag_entries:
                if name_ in value and value[name_]:
                    flags |= mask
            self.__SetFlags(flags)
        def _GetFlags(self):
            flags = self.__GetFlags()
            ret={}
            for name_, mask in self._flag_entries:
                ret[name_]=((flags & mask)==mask)
            return ret
            
        flags=property(_GetFlags, _SetFlags, doc='Sets whether or not shapes, joints, etc. will be drawn.')
        %}
}

%rename (__SetFlags) b2Draw::SetFlags;
%rename (__GetFlags) b2Draw::GetFlags;

#define e_convertVertices 0x1000

/* 
 DrawExtended

 This was a feeble attempt at speeding up the drawing routines. It converts the incoming
 b2Vec2s to screen coordinates so the Python side doesn't have to.
 
 But while I should have been profiling to see if vertex conversions were truly a bottleneck, I didn't.
 I think it only results in maybe 5 FPS gain at most.

 It makes for an interesting concept that I can extend some classes in this
 fashion and still have them work with Box2D thanks to inheritance. 

 I'm going to leave it in for the cleanliness aspect of it. The conversion
 routines can be disabled by setting convertVertices to False, or the base b2Draw
 can still be used.

*/

%extend b2DrawExtended {
public:
}


%typemap(directorin) (const b2Vec2* conv_vertices, int32 vertexCount) {
    $input = this->__Convert($1_name, $2_name);
}
%typemap(directorin) const b2Vec2& conv_p1 {
    $input = this->to_screen((b2Vec2&)$1_name);
}
%typemap(directorin) const b2Vec2& conv_p2 {
    $input = this->to_screen((b2Vec2&)$1_name);
}

%include "Box2D/Common/b2Draw.h"
%inline {
    class b2DrawExtended : public b2Draw {
    public:
        bool convertVertices;
        b2Vec2 center;
        b2Vec2 offset;
        float32 zoom;
        b2Vec2 screenSize;
        bool flipY, flipX;

        PyObject* __Convert(const b2Vec2* verts, int32 vertexCount) {
            PyObject* ret=PyTuple_New(vertexCount);
            if (GetFlags() & e_convertVertices) {
                // Convert the verts
                PyObject* vertex;
                long x, y;
                for (int i=0; i < vertexCount; i++) {
                    vertex = PyTuple_New(2);

                    x=(long)((verts[i].x * zoom) - offset.x);
                    if (flipX) { x = (long)screenSize.x - x; }

                    y=(long)(((verts[i].y * zoom) - offset.y));
                    if (flipY) { y = (long)screenSize.y - y; }

                    PyTuple_SetItem(vertex, 0, SWIG_From_long(x));
                    PyTuple_SetItem(vertex, 1, SWIG_From_long(y));

                    PyTuple_SetItem(ret, i, vertex);
                }
            } else {
                // Pass the verts in as-is
                PyObject* vertex;
                for (int i=0; i < vertexCount; i++) {
                    vertex = PyTuple_New(2);
                    PyTuple_SetItem(vertex, 0, SWIG_From_double((float32)verts[i].x));
                    PyTuple_SetItem(vertex, 1, SWIG_From_double((float32)verts[i].y));

                    PyTuple_SetItem(ret, i, vertex);
                }
            }
            return ret;
        }

        PyObject* to_screen(b2Vec2& point) {
            long x=(long)((point.x * zoom) - offset.x);
            if (flipX) { x = (long)screenSize.x - x; }

            long y=(long)(((point.y * zoom) - offset.y));
            if (flipY) { y = (long)screenSize.y - y; }

            PyObject* ret = PyTuple_New(2);
            PyTuple_SetItem(ret, 0, SWIG_From_long(x));
            PyTuple_SetItem(ret, 1, SWIG_From_long(y));
            return ret;

        }

        virtual void DrawPolygon(const b2Vec2* conv_vertices, int32 vertexCount, const b2Color& color) = 0;
        virtual void DrawSolidPolygon(const b2Vec2* conv_vertices, int32 vertexCount, const b2Color& color) = 0;
        virtual void DrawCircle(const b2Vec2& conv_p1, float32 radius, const b2Color& color) = 0;
        virtual void DrawSolidCircle(const b2Vec2& conv_p1, float32 radius, const b2Vec2& axis, const b2Color& color) = 0;
        virtual void DrawSegment(const b2Vec2& conv_p1, const b2Vec2& conv_p2, const b2Color& color) = 0;
        virtual void DrawTransform(const b2Transform& xf) = 0;

        void __SetFlags(uint32 flags) {
            if (convertVertices)
                SetFlags(e_convertVertices | flags);
            else 
                SetFlags(flags);
        }

        virtual ~b2DrawExtended() { }
        b2DrawExtended() : convertVertices(false), flipY(false), flipX(false) {
            center.SetZero();
            offset.SetZero();
            zoom=1.0;
            screenSize.SetZero();
            SetFlags(convertVertices ? e_convertVertices : 0x00);
        }

    };
}
%feature("director") b2DrawExtended;
