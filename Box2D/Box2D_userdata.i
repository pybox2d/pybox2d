/*
* Python SWIG interface file for Box2D (www.box2d.org)
*
* Copyright (c) 2008 kne / sirkne at gmail dot com
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

/* Note: Given that we have a definition (b2BodyDef) that takes the userData, then
   passes it onto the factory output (b2Body) upon creation, it's necessary 
   to intercept the CreateBody/Joint/Shape functions to increase the refcount
   for each of those functions.

   And upon being destroyed, the userData refcount must be decreased.
 */

%extend b2World {
public:        
    b2Body* __CreateBody(b2BodyDef* defn) {
        b2Body* ret;
        if (defn)
            Py_XINCREF((PyObject*)defn->userData);
        ret=self->CreateBody(defn);
        return ret;
    }
    b2Joint* __CreateJoint(b2JointDef* defn) {
        if (defn)
            Py_XINCREF((PyObject*)defn->userData);

        return self->CreateJoint(defn);
    }

    void DestroyBody(b2Body* body) {
        Py_XDECREF((PyObject*)body->GetUserData());
        self->DestroyBody(body);
    }

    void DestroyJoint(b2Joint* joint) {
        Py_XDECREF((PyObject*)joint->GetUserData());
        self->DestroyJoint(joint);
    }
}

%extend b2Body {
public:        
    void DestroyFixture(b2Fixture* fixture) {
        Py_XDECREF((PyObject*)fixture->GetUserData());
        self->DestroyFixture(fixture);
    }
    b2Fixture* __CreateFixture(b2FixtureDef* defn) {
        b2Fixture* ret;
        if (defn)
            Py_XINCREF((PyObject*)defn->userData);
        ret=self->CreateFixture(defn);
        return ret;
    }
    PyObject* __GetUserData() {
        PyObject* ret=(PyObject*)self->GetUserData();
        if (!ret) ret=Py_None;
        Py_XINCREF(ret);
        return ret;
    }
    void __SetUserData(PyObject* data) {
        Py_XDECREF((PyObject*)self->GetUserData());
        Py_INCREF(data);
        self->SetUserData(data);
    }
    void ClearUserData() {
        Py_XDECREF((PyObject*)self->GetUserData());
        self->SetUserData(NULL);
    }
    %pythoncode %{
        userData = property(__GetUserData, __SetUserData)
    %}
}

%extend b2Joint {
public:        
    PyObject* __GetUserData() {
        PyObject* ret=(PyObject*)self->GetUserData();
        if (!ret) ret=Py_None;
        Py_XINCREF(ret);
        return ret;
    }
    void __SetUserData(PyObject* data) {
        Py_XDECREF((PyObject*)self->GetUserData());
        Py_INCREF(data);
        self->SetUserData(data);
    }
    void ClearUserData() {
        Py_XDECREF((PyObject*)self->GetUserData());
        self->SetUserData(NULL);
    }
    %pythoncode %{
        userData = property(__GetUserData, __SetUserData)
    %}
}

%extend b2Fixture {
public:        
    PyObject* __GetUserData() {
        PyObject* ret=(PyObject*)self->GetUserData();
        if (!ret) ret=Py_None;
        Py_XINCREF(ret);
        return ret;
    }
    void __SetUserData(PyObject* data) {
        Py_XDECREF((PyObject*)self->GetUserData());
        Py_INCREF(data);
        self->SetUserData(data);
    }
    void ClearUserData() {
        Py_XDECREF((PyObject*)self->GetUserData());
        self->SetUserData(NULL);
    }
    %pythoncode %{
        userData = property(__GetUserData, __SetUserData)
    %}
}

//Allow access to userData in definitions, with proper destruction
%extend b2JointDef {
public:
    PyObject* __GetUserData() {
        PyObject* ret;
        if (!self->userData)
            ret=Py_None;
        else
            ret=(PyObject*)self->userData;
        Py_INCREF((PyObject*)ret);
        return ret;
    }
    void __SetUserData(PyObject* data) {
        Py_XDECREF((PyObject*)self->userData);
        Py_INCREF(data);
        self->userData=(void*)data;
    }
    void ClearUserData() {
        Py_XDECREF((PyObject*)self->userData);
        self->userData=NULL;
    }
    %pythoncode %{
        userData = property(__GetUserData, __SetUserData)
        def __del__(self):
            self.ClearUserData()
    %}
}

%extend b2BodyDef {
public:
    PyObject* __GetUserData() {
        PyObject* ret;
        if (!self->userData)
            ret=Py_None;
        else
            ret=(PyObject*)self->userData;
        Py_INCREF((PyObject*)ret);
        return ret;
    }
    void __SetUserData(PyObject* data) {
        Py_XDECREF((PyObject*)self->userData);
        Py_INCREF(data);
        self->userData=(void*)data;
    }
    void ClearUserData() {
        Py_XDECREF((PyObject*)self->userData);
        self->userData=NULL;
    }
    %pythoncode %{
        userData = property(__GetUserData, __SetUserData)
        def __del__(self):
            self.ClearUserData()
    %}
}

%extend b2FixtureDef {
public:
    PyObject* __GetUserData() {
        PyObject* ret;
        if (!self->userData)
            ret=Py_None;
        else
            ret=(PyObject*)self->userData;
        Py_INCREF((PyObject*)ret);
        return ret;
    }
    void __SetUserData(PyObject* data) {
        Py_XDECREF((PyObject*)self->userData);
        Py_INCREF(data);
        self->userData=(void*)data;
    }
    void ClearUserData() {
        Py_XDECREF((PyObject*)self->userData);
        self->userData=NULL;
    }
    %pythoncode %{
        userData = property(__GetUserData, __SetUserData)
        def __del__(self):
            self.ClearUserData()
    %}
}

// These renames are intentionally below the above CreateBody, as they will rename the 
// original C++ versions and not the ones I have written.
%ignore SetUserData;
%ignore GetUserData;
%ignore userData;

%newobject b2World::__CreateBody;
%newobject b2World::__CreateJoint;
%newobject b2Body::__CreateFixture;
%rename (__CreateFixture) b2Body::CreateFixture(const b2Shape* shape, float32 density);

%ignore b2World::CreateBody;
%ignore b2World::CreateJoint;
%ignore b2Body::CreateFixture;

%ignore b2World::DestroyBody;
%ignore b2World::DestroyJoint;
%ignore b2Body::DestroyFixture;
