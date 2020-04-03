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

%inline %{
#define pybox2d_float_from_sequence(_sequence, _num, _dest, _err_msg) \
    {                                                                 \
        PyObject* item=PySequence_GetItem(_sequence, _num);           \
        int res=SWIG_AsVal_float(item, _dest);                        \
        Py_XDECREF(item);                                             \
        if (!SWIG_IsOK(res)) {                                        \
            PyErr_SetString(PyExc_TypeError,_err_msg);                \
            SWIG_fail;                                                \
        }                                                             \
    }

%}


//input - $input -> ($1_type) $1 $1_descriptor
%typemap(in) b2Vec2* self {
    int res1 = SWIG_ConvertPtr($input, (void**)&$1, $descriptor(b2Vec2*), 0);
    if (!SWIG_IsOK(res1)) {
        SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
    }
}
%typemap(in) b2Vec3* self {
    int res1 = SWIG_ConvertPtr($input, (void**)&$1, $descriptor(b2Vec3*), 0);
    if (!SWIG_IsOK(res1)) {
        SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
    }
}
%typemap(in) b2Color* self {
    int res1 = SWIG_ConvertPtr($input, (void**)&$1, $descriptor(b2Color*), 0);
    if (!SWIG_IsOK(res1)) {
        SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
    }
}

//Resolve ambiguities in overloaded functions when you pass a tuple or list when 
//SWIG expects a b2Vec2 (b2Vec3, b2Color)
%typemap(typecheck,precedence=SWIG_TYPECHECK_POINTER) b2Vec2*,b2Vec2& {
   $1 = (PySequence_Check($input) || 
         SWIG_CheckState(SWIG_ConvertPtr($input, 0, $descriptor(b2Vec2*), 0))
        ) ? 1 : 0;
}
%typemap(typecheck,precedence=SWIG_TYPECHECK_POINTER) b2Vec3*,b2Vec3& {
   $1 = (PySequence_Check($input) || 
         SWIG_CheckState(SWIG_ConvertPtr($input, 0, $descriptor(b2Vec3*), 0))
        ) ? 1 : 0;
}
%typemap(typecheck,precedence=SWIG_TYPECHECK_POINTER) b2Color*,b2Color& {
   $1 = (PySequence_Check($input) || 
         SWIG_CheckState(SWIG_ConvertPtr($input, 0, $descriptor(b2Color*), 0))
        ) ? 1 : 0;
}

// Allow b2Vec2* arguments be passed in as tuples or lists
%typemap(in) b2Vec2* (b2Vec2 temp) {
    if (PySequence_Check($input)) {
        if (PySequence_Size($input) != 2) {
            PyErr_Format(PyExc_TypeError, "Expected tuple or list of length 2, got length %ld", (long) PySequence_Size($input));
            SWIG_fail;
        }
        pybox2d_float_from_sequence($input, 0, &temp.x, "Converting from sequence to b2Vec2, expected int/float arguments index 0");
        pybox2d_float_from_sequence($input, 1, &temp.y, "Converting from sequence to b2Vec2, expected int/float arguments index 1");
    } else if ($input==Py_None) {
        temp.Set(0.0f,0.0f);
    } else {
        int res1 = SWIG_ConvertPtr($input, (void**)&$1, $1_descriptor, 0);
        if (!SWIG_IsOK(res1)) {
            SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
            SWIG_fail;
        }
        temp =(b2Vec2&) *$1;
    }
    $1 = &temp;
}

// Allow b2Color* arguments be passed in as tuples or lists
%typemap(in) b2Color* (b2Color temp) {
    //input - $input -> ($1_type) $1 $1_descriptor
    if (PySequence_Check($input)) {
        if (PySequence_Size($input) != 3) {
            PyErr_Format(PyExc_TypeError, "Expected tuple or list of length 3, got length %ld", (long) PySequence_Size($input));
            SWIG_fail;
        }
        pybox2d_float_from_sequence($input, 0, &temp.r, "Converting from sequence to b2Color, expected int/float arguments index 0");
        pybox2d_float_from_sequence($input, 1, &temp.g, "Converting from sequence to b2Color, expected int/float arguments index 1");
        pybox2d_float_from_sequence($input, 2, &temp.b, "Converting from sequence to b2Color, expected int/float arguments index 2");
    } else if ($input==Py_None) {
        temp.Set(0.0f,0.0f,0.0f);
    } else {
        int res1 = SWIG_ConvertPtr($input, (void**)&$1, $1_descriptor, 0);
        if (!SWIG_IsOK(res1)) {
            SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
            SWIG_fail;
        }
        temp =(b2Color&) *$1;
    }
    $1 = &temp;
}

// Allow b2Vec3* arguments be passed in as tuples or lists
%typemap(in) b2Vec3* (b2Vec3 temp) {
    //input - $input -> ($1_type) $1 $1_descriptor
    if (PySequence_Check($input)) {
        if (PySequence_Size($input) != 3) {
            PyErr_Format(PyExc_TypeError, "Expected tuple or list of length 3, got length %ld", (long) PySequence_Size($input));
            SWIG_fail;
        }
        pybox2d_float_from_sequence($input, 0, &temp.x, "Converting from sequence to b2Vec3, expected int/float arguments index 0");
        pybox2d_float_from_sequence($input, 1, &temp.y, "Converting from sequence to b2Vec3, expected int/float arguments index 1");
        pybox2d_float_from_sequence($input, 2, &temp.z, "Converting from sequence to b2Vec3, expected int/float arguments index 2");
    } else if ($input==Py_None) {
        temp.Set(0.0f,0.0f,0.0f);
    } else {
        int res1 = SWIG_ConvertPtr($input, (void**)&$1, $1_descriptor, 0);
        if (!SWIG_IsOK(res1)) {
            SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
            SWIG_fail;
        }
        temp =(b2Vec3&) *$1;
    }
    $1 = &temp;
}

// Allow b2Vec2& arguments be passed in as tuples or lists
%typemap(in) b2Vec2& (b2Vec2 temp) {
    //input - $input -> ($1_type) $1 $1_descriptor
    if (PySequence_Check($input)) {
        if (PySequence_Size($input) != 2) {
            PyErr_Format(PyExc_TypeError, "Expected tuple or list of length 2, got length %ld", (long) PySequence_Size($input));
            SWIG_fail;
        }
        pybox2d_float_from_sequence($input, 0, &temp.x, "Converting from sequence to b2Vec2, expected int/float arguments index 0");
        pybox2d_float_from_sequence($input, 1, &temp.y, "Converting from sequence to b2Vec2, expected int/float arguments index 1");
    } else if ($input == Py_None) {
        temp.Set(0.0f,0.0f);
    } else {
        int res1 = SWIG_ConvertPtr($input, (void**)&$1, $1_descriptor, 0);
        if (!SWIG_IsOK(res1)) {
            SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
        }
        temp =(b2Vec2&) *$1;
    }
    $1 = &temp;
}

// Allow b2Color& arguments be passed in as tuples or lists
%typemap(in) b2Color& (b2Color temp) {
    //input - $input -> ($1_type) $1 $1_descriptor
    if (PySequence_Check($input)) {
        if (PySequence_Size($input) != 3) {
            PyErr_Format(PyExc_TypeError, "Expected tuple or list of length 3, got length %ld", (long) PySequence_Size($input));
            SWIG_fail;
        }
        pybox2d_float_from_sequence($input, 0, &temp.r, "Converting from sequence to b2Color, expected int/float arguments index 0");
        pybox2d_float_from_sequence($input, 1, &temp.g, "Converting from sequence to b2Color, expected int/float arguments index 1");
        pybox2d_float_from_sequence($input, 2, &temp.b, "Converting from sequence to b2Color, expected int/float arguments index 2");
    } else if ($input==Py_None) {
        temp.Set(0.0f,0.0f,0.0f);
    } else {
        int res1 = SWIG_ConvertPtr($input, (void**)&$1, $1_descriptor, 0);
        if (!SWIG_IsOK(res1)) {
            SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
            SWIG_fail;
        }
        temp =(b2Color&) *$1;
    }
    $1 = &temp;
}

// Allow b2Vec3& arguments be passed in as tuples or lists
%typemap(in) b2Vec3& (b2Vec3 temp) {
    //input - $input -> ($1_type) $1 $1_descriptor
    if (PySequence_Check($input)) {
        if (PySequence_Size($input) != 3) {
            PyErr_Format(PyExc_TypeError, "Expected tuple or list of length 3, got length %ld", (long) PySequence_Size($input));
            SWIG_fail;
        }
        pybox2d_float_from_sequence($input, 0, &temp.x, "Converting from sequence to b2Vec3, expected int/float arguments index 0");
        pybox2d_float_from_sequence($input, 1, &temp.y, "Converting from sequence to b2Vec3, expected int/float arguments index 1");
        pybox2d_float_from_sequence($input, 2, &temp.z, "Converting from sequence to b2Vec3, expected int/float arguments index 2");
    } else if ($input==Py_None) {
        temp.Set(0.0f,0.0f,0.0f);
    } else {
        int res1 = SWIG_ConvertPtr($input, (void**)&$1, $1_descriptor, 0);
        if (!SWIG_IsOK(res1)) {
            SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
            SWIG_fail;
        }
        temp =(b2Vec3&) *$1;
    }
    $1 = &temp;
}

//Allow access to void* types
%typemap(in) void* {
    $1 = $input;
    Py_INCREF((PyObject*)$1);
}
%typemap(out) void* {
    if (!$1)
        $result=Py_None;
    else
        $result=(PyObject*)$1;

    Py_INCREF($result);
}

%typemap(in) b2Manifold* oldManifold{
    void* argp=NULL;
    int res3 = SWIG_ConvertPtr($input, &argp, $descriptor(b2Manifold *), 0);
    Swig::Director *director = SWIG_DIRECTOR_CAST(arg1);
#ifdef _SWIG_KWARGS
    bool upcall_ = (director && (director->swig_get_self()==obj0));
#else
    bool upcall_ = (director && (director->swig_get_self()==swig_obj[0]));
#endif
    if (upcall_) {
        /* This conversion fails on py3k when attempting to call the 
           b2_defaultListener.PreSolve() and I cannot quite figure out why.
           I think it has something to do with the fact that the default implementation
           is in C++, the director method gets called, then it attempts to call a nonexistent
           Python function, ... or something like that.

           In any case, the base b2ContactListener does nothing, so whatever args
           we pass it, that's fine.
           TODO
           */
    } else if (!SWIG_IsOK(res3)) {
        SWIG_exception_fail(SWIG_ArgError(res3), "in method '" "$symname" "', argument " "$1_name"" of type '" "$1_type""'"); 
    }
    $1 = reinterpret_cast<b2Manifold*>(argp);
}

%typemap(directorin) (const b2Vec2* vertices, int32 vertexCount) {
    $input = PyTuple_New(vertexCount);
    PyObject* vertex;
    for (int i=0; i < vertexCount; i++) {
        vertex = PyTuple_New(2);
        PyTuple_SetItem(vertex, 0, SWIG_From_double((float32)vertices[i].x));
        PyTuple_SetItem(vertex, 1, SWIG_From_double((float32)vertices[i].y));

        PyTuple_SetItem($input, i, vertex);
    }
}

%typemap(directorin) b2Vec2& {
    $input = PyTuple_New(2);
    PyTuple_SetItem( $input, 0, SWIG_From_double((float32)$1_name.x));
    PyTuple_SetItem( $input, 1, SWIG_From_double((float32)$1_name.y));
}

/* Properly downcast joints for all return values using b2Joint */
%typemap(out) b2Joint* {
    
    if ($1) {
        switch (($1)->GetType())
        {
        case e_revoluteJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2RevoluteJoint*), 0); break;
        case e_prismaticJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2PrismaticJoint*), 0); break;
        case e_distanceJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2DistanceJoint*), 0); break;
        case e_pulleyJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2PulleyJoint*), 0); break;
        case e_mouseJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2MouseJoint*), 0); break;
        case e_gearJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2GearJoint*), 0); break;
        case e_wheelJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2WheelJoint*), 0); break;
        case e_weldJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2WeldJoint*), 0); break;
        case e_frictionJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2FrictionJoint*), 0); break;
        case e_ropeJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2RopeJoint*), 0); break;
        case e_motorJoint:
            $result=SWIG_NewPointerObj($1, $descriptor(b2MotorJoint*), 0); break;
        case e_unknownJoint:
        default:
            $result=SWIG_NewPointerObj($1, $descriptor(b2Joint*), 0); break;
            break;
        }
    } else {
        $result=Py_None; 
        Py_INCREF($result);
    }
}

/* Properly downcast shapes for all return values using b2Shape */
%typemap(out) b2Shape* {
    if ($1) {
        switch (($1)->GetType())
        {
        case b2Shape::e_circle:
            $result=SWIG_NewPointerObj($1, $descriptor(b2CircleShape*), 0); break;
        case b2Shape::e_polygon:
            $result=SWIG_NewPointerObj($1, $descriptor(b2PolygonShape*), 0); break;
        case b2Shape::e_edge:
            $result=SWIG_NewPointerObj($1, $descriptor(b2EdgeShape*), 0); break;
        case b2Shape::e_chain:
            $result=SWIG_NewPointerObj($1, $descriptor(b2ChainShape*), 0); break;
        default:
            $result=SWIG_NewPointerObj($1, $descriptor(b2Shape*), 0); break;
        }
    } else {
        $result=Py_None; 
        Py_INCREF($result);
    }
}

