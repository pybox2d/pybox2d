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

/**** JointDef ****/
%extend b2JointDef {
public:
    %pythoncode %{
        def to_kwargs(self):
            """
            Returns a dictionary representing this joint definition
            """
            def is_prop(attr):
                try:
                    is_property = isinstance(getattr(cls, attr), property)
                except AttributeError:
                    return False

                return is_property and attr not in skip_props

            skip_props = ['anchor', 'anchorA', 'anchorB', 'axis']
            cls = type(self)
            return {attr: getattr(self, attr)
                    for attr in dir(self)
                    if is_prop(attr)
                    }
    %}
}

/**** Joint ****/
%extend b2Joint {
public:
    %pythoncode %{
    __eq__ = b2JointCompare
    __ne__ = lambda self,other: not b2JointCompare(self,other)

    # Read-only
    next = property(__GetNext, None)
    bodyA = property(__GetBodyA, None)
    bodyB = property(__GetBodyB, None)
    type = property(__GetType, None)
    enabled = property(__IsEnabled, None)
    active = enabled  # backward compatibility
    anchorB = property(__GetAnchorB, None)
    anchorA = property(__GetAnchorA, None)
    collideConnected = property(__GetCollideConnected, None)
    
    def getAsType(self):
        """
        Backward compatibility
        """
        return self
    %}

}

%rename(__GetNext) b2Joint::GetNext;
%rename(__GetBodyA) b2Joint::GetBodyA;
%rename(__GetBodyB) b2Joint::GetBodyB;
%rename(__GetType) b2Joint::GetType;
%rename(__IsEnabled) b2Joint::IsEnabled;
%rename(__GetAnchorA) b2Joint::GetAnchorA;
%rename(__GetAnchorB) b2Joint::GetAnchorB;
%rename(__GetCollideConnected) b2Joint::GetCollideConnected;

/**** RevoluteJoint ****/
%extend b2RevoluteJoint {
public:
    %pythoncode %{

        # Read-write properties
        motorSpeed = property(__GetMotorSpeed, __SetMotorSpeed)
        upperLimit = property(__GetUpperLimit, lambda self, v: self.SetLimits(self.lowerLimit, v))
        lowerLimit = property(__GetLowerLimit, lambda self, v: self.SetLimits(v, self.upperLimit))
        limits = property(lambda self: (self.lowerLimit, self.upperLimit), lambda self, v: self.SetLimits(*v) )
        motorEnabled = property(__IsMotorEnabled, __EnableMotor)
        limitEnabled = property(__IsLimitEnabled, __EnableLimit)

        # Read-only
        angle = property(__GetJointAngle, None)
        speed = property(__GetJointSpeed, None)

        # Write-only
        maxMotorTorque = property(None, __SetMaxMotorTorque)

    %}
}

%rename(__IsMotorEnabled) b2RevoluteJoint::IsMotorEnabled;
%rename(__GetUpperLimit) b2RevoluteJoint::GetUpperLimit;
%rename(__GetLowerLimit) b2RevoluteJoint::GetLowerLimit;
%rename(__GetJointAngle) b2RevoluteJoint::GetJointAngle;
%rename(__GetMotorSpeed) b2RevoluteJoint::GetMotorSpeed;
%rename(__GetJointSpeed) b2RevoluteJoint::GetJointSpeed;
%rename(__IsLimitEnabled) b2RevoluteJoint::IsLimitEnabled;
%rename(__SetMotorSpeed) b2RevoluteJoint::SetMotorSpeed;
%rename(__EnableLimit) b2RevoluteJoint::EnableLimit;
%rename(__SetMaxMotorTorque) b2RevoluteJoint::SetMaxMotorTorque;
%rename(__EnableMotor) b2RevoluteJoint::EnableMotor;

/**** WheelJoint ****/
%extend b2WheelJoint {
public:
    %pythoncode %{

        # Read-write properties
        motorSpeed = property(__GetMotorSpeed, __SetMotorSpeed)
        motorEnabled = property(__IsMotorEnabled, __EnableMotor)
        maxMotorTorque = property(__GetMaxMotorTorque, __SetMaxMotorTorque)
        stiffness = property(__GetStiffness , __SetStiffness)
        damping = property(__GetDamping , __SetDamping)

        # Read-only
        linear_speed = property(__GetJointLinearSpeed, None)
        speed = linear_speed  # backward-compatibility
        angular_speed = property(__GetJointAngularSpeed, None)
        angle = property(__GetJointAngle, None)
        translation = property(__GetJointTranslation, None)

    %}
}

%rename(__IsMotorEnabled) b2WheelJoint::IsMotorEnabled;
%rename(__GetMotorSpeed) b2WheelJoint::GetMotorSpeed;
%rename(__GetJointLinearSpeed) b2WheelJoint::GetJointLinearSpeed;
%rename(__GetJointAngularSpeed) b2WheelJoint::GetJointAngularSpeed;
%rename(__GetJointAngle) b2WheelJoint::GetJointAngle;
%rename(__GetJointTranslation) b2WheelJoint::GetJointTranslation;
%rename(__IsLimitEnabled) b2WheelJoint::IsLimitEnabled;
%rename(__SetMotorSpeed) b2WheelJoint::SetMotorSpeed;
%rename(__GetStiffness) b2WheelJoint::GetStiffness;
%rename(__SetStiffness) b2WheelJoint::SetStiffness;
%rename(__GetDamping) b2WheelJoint::GetDamping;
%rename(__SetDamping) b2WheelJoint::SetDamping;
%rename(__GetMaxMotorTorque) b2WheelJoint::GetMaxMotorTorque;
%rename(__SetMaxMotorTorque) b2WheelJoint::SetMaxMotorTorque;
%rename(__EnableMotor) b2WheelJoint::EnableMotor;

/**** PrismaticJoint ****/
%extend b2PrismaticJoint {
public:
    %pythoncode %{

        # Read-write properties
        motorSpeed = property(__GetMotorSpeed, __SetMotorSpeed)
        motorEnabled = property(__IsMotorEnabled, __EnableMotor)
        limitEnabled = property(__IsLimitEnabled, __EnableLimit)
        upperLimit = property(__GetUpperLimit, lambda self, v: self.SetLimits(self.lowerLimit, v))
        lowerLimit = property(__GetLowerLimit, lambda self, v: self.SetLimits(v, self.upperLimit))
        limits = property(lambda self: (self.lowerLimit, self.upperLimit), lambda self, v: self.SetLimits(*v) )
        maxMotorForce = property(__GetMaxMotorForce, __SetMaxMotorForce)

        # Read-only
        translation = property(__GetJointTranslation, None)
        speed = property(__GetJointSpeed, None)

    %}
}

%rename(__IsMotorEnabled) b2PrismaticJoint::IsMotorEnabled;
%rename(__GetMotorSpeed) b2PrismaticJoint::GetMotorSpeed;
%rename(__GetJointTranslation) b2PrismaticJoint::GetJointTranslation;
%rename(__GetUpperLimit) b2PrismaticJoint::GetUpperLimit;
%rename(__GetJointSpeed) b2PrismaticJoint::GetJointSpeed;
%rename(__IsLimitEnabled) b2PrismaticJoint::IsLimitEnabled;
%rename(__GetLowerLimit) b2PrismaticJoint::GetLowerLimit;
%rename(__SetMotorSpeed) b2PrismaticJoint::SetMotorSpeed;
%rename(__EnableLimit) b2PrismaticJoint::EnableLimit;
%rename(__SetMaxMotorForce) b2PrismaticJoint::SetMaxMotorForce;
%rename(__GetMaxMotorForce) b2PrismaticJoint::GetMaxMotorForce;
%rename(__EnableMotor) b2PrismaticJoint::EnableMotor;

/**** DistanceJoint ****/
%extend b2DistanceJoint {
public:
    %pythoncode %{
        def set_linear_stiffness(self, frequency, ratio):
            stiffness, damping = b2LinearStiffness(
                self.frequency, ratio, self.bodyA, self.bodyB)
            self.stiffness = stiffness
            self.damping = damping

        # Read-write properties
        length = property(__GetLength, __SetLength)
        stiffness = property(__GetStiffness, __SetStiffness)
        damping = property(__GetDamping, __SetDamping)

    %}
}

%rename(__GetLength) b2DistanceJoint::GetLength;
%rename(__SetLength) b2DistanceJoint::SetLength;
%rename(__GetDamping) b2DistanceJoint::GetDamping;
%rename(__SetDamping) b2DistanceJoint::SetDamping;
%rename(__GetStiffness) b2DistanceJoint::GetStiffness;
%rename(__SetStiffness) b2DistanceJoint::SetStiffness;

/**** RopeJoint ****/
%extend b2RopeJoint {
public:
    %pythoncode %{

        # Read-only properties
        maxLength = property(__GetMaxLength, None)
        length = property(__GetLength, None)

        @property
        def limitState(self):
            # Backward-compatibility:
            #enum b2LimitState
            #{
            #	e_inactiveLimit,
            #	e_atLowerLimit,
            #	e_atUpperLimit,
            #	e_equalLimits
            #};
            if (self.length - self.maxLength) > 0.0:
                return 2  # e_atUpperLimit;
            return 0   # e_inactiveLimit
            
        # Read-write properties

    %}
}
%rename(__GetLength) b2RopeJoint::GetLength;
%rename(__GetMaxLength) b2RopeJoint::GetMaxLength;

/**** PulleyJoint ****/
%extend b2PulleyJoint {
public:
    %pythoncode %{

        # Read-only
        groundAnchorB = property(__GetGroundAnchorB, None)
        groundAnchorA = property(__GetGroundAnchorA, None)
        ratio = property(__GetRatio, None)
        lengthB = length2 = property(__GetLengthB, None)
        lengthA = length1 = property(__GetLengthA, None)

    %}
}

%rename(__GetGroundAnchorB) b2PulleyJoint::GetGroundAnchorB;
%rename(__GetGroundAnchorA) b2PulleyJoint::GetGroundAnchorA;
%rename(__GetLengthB) b2PulleyJoint::GetLengthB;
%rename(__GetLengthA) b2PulleyJoint::GetLengthA;
%rename(__GetRatio) b2PulleyJoint::GetRatio;

/**** MouseJoint ****/
%extend b2MouseJoint {
public:
    %pythoncode %{

        # Read-write properties
        maxForce = property(__GetMaxForce, __SetMaxForce)
        frequency = property(__GetFrequency, __SetFrequency)
        dampingRatio = property(__GetDampingRatio, __SetDampingRatio)
        target = property(__GetTarget, __SetTarget)

    %}
}

%rename(__GetMaxForce) b2MouseJoint::GetMaxForce;
%rename(__GetFrequency) b2MouseJoint::GetFrequency;
%rename(__GetDampingRatio) b2MouseJoint::GetDampingRatio;
%rename(__GetTarget) b2MouseJoint::GetTarget;
%rename(__SetDampingRatio) b2MouseJoint::SetDampingRatio;
%rename(__SetTarget) b2MouseJoint::SetTarget;
%rename(__SetMaxForce) b2MouseJoint::SetMaxForce;
%rename(__SetFrequency) b2MouseJoint::SetFrequency;

/**** GearJoint ****/
%extend b2GearJoint {
public:
    %pythoncode %{
        # Read-write properties
        ratio = property(__GetRatio, __SetRatio)

    %}
}

%rename(__GetRatio) b2GearJoint::GetRatio;
%rename(__SetRatio) b2GearJoint::SetRatio;

/**** WeldJoint ****/
%extend b2WeldJoint {
}

/**** FrictionJoint ****/
%extend b2FrictionJoint {
public:
    %pythoncode %{
        # Read-write properties
        maxForce = property(__GetMaxForce, __SetMaxForce)
        maxTorque = property(__GetMaxTorque, __SetMaxTorque)
    %}
}

%rename(__GetMaxForce) b2FrictionJoint::GetMaxForce;
%rename(__GetMaxTorque) b2FrictionJoint::GetMaxTorque;
%rename(__SetMaxTorque) b2FrictionJoint::SetMaxTorque;
%rename(__SetMaxForce) b2FrictionJoint::SetMaxForce;

/**** Add some of the functionality that Initialize() offers for joint definitions ****/
/**** DistanceJointDef ****/
%extend b2DistanceJointDef {
    %pythoncode %{
        def __update_length(self):
            if self.bodyA and self.bodyB:
                d = self.anchorB - self.anchorA
                self.length = d.length
        def __set_anchorA(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.__update_length()
        def __set_anchorB(self, value):
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
            self.__update_length()
        def __get_anchorA(self):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            return self.bodyA.GetWorldPoint(self.localAnchorA)
        def __get_anchorB(self):
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            return self.bodyB.GetWorldPoint(self.localAnchorB)

        anchorA = property(__get_anchorA, __set_anchorA, 
                doc="""Body A's anchor in world coordinates.
                    Getting the property depends on both bodyA and localAnchorA.
                    Setting the property requires that bodyA be set.""")
        anchorB = property(__get_anchorB, __set_anchorB, 
                doc="""Body B's anchor in world coordinates.
                    Getting the property depends on both bodyB and localAnchorB.
                    Setting the property requires that bodyB be set.""")
    %}
}

%feature("shadow") b2DistanceJointDef::b2DistanceJointDef() %{
    def __init__(self, bodyA=None, bodyB=None, frequencyHz=None, dampingRatio=None, **kwargs):
        _Box2D.b2DistanceJointDef_swiginit(self,_Box2D.new_b2DistanceJointDef())

        if bodyA is not None or bodyB is not None:
            # Make sure that bodyA and bodyB are defined before the rest
            _init_kwargs(self, bodyA=bodyA, bodyB=bodyB)

        if frequencyHz is not None or dampingRatio is not None:
            # Backward-compatibility: automatically calculate new parameters
            # stiffness and damping
            if frequencyHz is None or dampingRatio is None:
                raise ValueError(
                    'Must specify both frequencyHz and dampingRatio or neither'
                )

            stiffness, damping = b2LinearStiffness(frequencyHz, dampingRatio, bodyA, bodyB)
            kwargs['stiffness'] = stiffness
            kwargs['damping'] = damping

        _init_kwargs(self, bodyA=bodyA, bodyB=bodyB, **kwargs)

        if 'localAnchorA' in kwargs and 'localAnchorB' in kwargs and 'length' not in kwargs:
            self.__update_length()
%}


/**** FrictionJointDef ****/
%extend b2FrictionJointDef {
    %pythoncode %{
        def __set_anchor(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
        def __get_anchor(self):
            if self.bodyA:
                return self.bodyA.GetWorldPoint(self.localAnchorA)
            if self.bodyB:
                return self.bodyB.GetWorldPoint(self.localAnchorB)
            raise ValueError('Neither body was set; unable to get world point.')

        anchor = property(__get_anchor, __set_anchor, 
                doc="""The anchor in world coordinates.
                    Getting the property depends on either bodyA and localAnchorA or 
                    bodyB and localAnchorB.
                    Setting the property requires that both bodies be set.""")
    %}
}

%feature("shadow") b2FrictionJointDef::b2FrictionJointDef() %{
    def __init__(self, **kwargs):
        _Box2D.b2FrictionJointDef_swiginit(self,_Box2D.new_b2FrictionJointDef())
        _init_jointdef_kwargs(self, **kwargs)
%}


/**** WheelJointDef ****/
%extend b2WheelJointDef {
    %pythoncode %{
        def __set_anchor(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
        def __get_anchor(self):
            if self.bodyA:
                return self.bodyA.GetWorldPoint(self.localAnchorA)
            if self.bodyB:
                return self.bodyB.GetWorldPoint(self.localAnchorB)
            raise ValueError('Neither body was set; unable to get world point.')
        def __set_axis(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            self.localAxisA=self.bodyA.GetLocalVector(value)
        def __get_axis(self):
            if self.bodyA:
                return self.bodyA.GetWorldVector(self.localAxisA)
            raise ValueError('Body A unset; unable to get world vector.')

        anchor = property(__get_anchor, __set_anchor, 
                doc="""The anchor in world coordinates.
                    Getting the property depends on either bodyA and localAnchorA or 
                    bodyB and localAnchorB.
                    Setting the property requires that both bodies be set.""")
        axis = property(__get_axis, __set_axis, 
                doc="""The world translation axis on bodyA.
                    Getting the property depends on bodyA and localAxisA.
                    Setting the property requires that bodyA be set.""")
    %}
}
%feature("shadow") b2WheelJointDef::b2WheelJointDef() %{
    def __init__(self, bodyA=None, bodyB=None, frequencyHz=None, dampingRatio=None, **kwargs):
        _Box2D.b2WheelJointDef_swiginit(self,_Box2D.new_b2WheelJointDef())

        if bodyA is not None or bodyB is not None:
            # Make sure that bodyA and bodyB are defined before the rest
            _init_kwargs(self, bodyA=bodyA, bodyB=bodyB)

        if frequencyHz is not None or dampingRatio is not None:
            # Backward-compatibility: automatically calculate new parameters
            # stiffness and damping
            if frequencyHz is None or dampingRatio is None:
                raise ValueError(
                    'Must specify both frequencyHz and dampingRatio or neither'
                )

            stiffness, damping = b2LinearStiffness(frequencyHz, dampingRatio, bodyA, bodyB)
            kwargs['stiffness'] = stiffness
            kwargs['damping'] = damping

        _init_kwargs(self, bodyA=bodyA, bodyB=bodyB, **kwargs)
%}

/**** PrismaticJointDef ****/
%extend b2PrismaticJointDef {
    %pythoncode %{
        def __set_anchor(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
        def __get_anchor(self):
            if self.bodyA:
                return self.bodyA.GetWorldPoint(self.localAnchorA)
            if self.bodyB:
                return self.bodyB.GetWorldPoint(self.localAnchorB)
            raise ValueError('Neither body was set; unable to get world point.')
        def __set_axis(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            self.localAxisA=self.bodyA.GetLocalVector(value)
        def __get_axis(self):
            if not self.bodyA:
                raise ValueError('Body A unset; unable to get world vector.')
            return self.bodyA.GetWorldVector(self.localAxisA)

        anchor = property(__get_anchor, __set_anchor, 
                doc="""The anchor in world coordinates.
                    Getting the property depends on either bodyA and localAnchorA or 
                    bodyB and localAnchorB.
                    Setting the property requires that both bodies be set.""")
        axis = property(__get_axis, __set_axis, 
                doc="""The world translation axis on bodyA.
                    Getting the property depends on bodyA and localAxisA.
                    Setting the property requires that bodyA be set.""")
    %}
}

%feature("shadow") b2PrismaticJointDef::b2PrismaticJointDef() %{
    def __init__(self, **kwargs):
        _Box2D.b2PrismaticJointDef_swiginit(self,_Box2D.new_b2PrismaticJointDef())
        _init_jointdef_kwargs(self, **kwargs)
        if self.bodyA and self.bodyB and 'referenceAngle' not in kwargs:
            self.referenceAngle = self.bodyB.angle - self.bodyA.angle
%}

/**** PulleyJointDef ****/
%extend b2PulleyJointDef {
    %pythoncode %{
        def __update_length(self):
            if self.bodyA:
                d1 = self.anchorA - self.groundAnchorA
                self.lengthA = d1.length
            if self.bodyB:
                d1 = self.anchorB - self.groundAnchorB
                self.lengthB = d1.length
        def __set_anchorA(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.__update_length()
        def __set_anchorB(self, value):
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
            self.__update_length()
        def __get_anchorA(self):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            return self.bodyA.GetWorldPoint(self.localAnchorA)
        def __get_anchorB(self):
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            return self.bodyB.GetWorldPoint(self.localAnchorB)

        anchorA = property(__get_anchorA, __set_anchorA, 
                doc="""Body A's anchor in world coordinates.
                    Getting the property depends on both bodyA and localAnchorA.
                    Setting the property requires that bodyA be set.""")
        anchorB = property(__get_anchorB, __set_anchorB, 
                doc="""Body B's anchor in world coordinates.
                    Getting the property depends on both bodyB and localAnchorB.
                    Setting the property requires that bodyB be set.""")
    %}
}

%feature("shadow") b2PulleyJointDef::b2PulleyJointDef() %{
    def __init__(self, **kwargs):
        _Box2D.b2PulleyJointDef_swiginit(self,_Box2D.new_b2PulleyJointDef())
        _init_jointdef_kwargs(self, **kwargs)
        self.__init_pulley__(**kwargs)
    
    def __init_pulley__(self, anchorA=None, anchorB=None, lengthA=None, lengthB=None, groundAnchorA=None, groundAnchorB=None, maxLengthA=None, maxLengthB=None, ratio=None, **kwargs):
        lengthA_set, lengthB_set = False, False
        if anchorA is not None or anchorB is not None:
            # Some undoing -- if the user specified the length, we might
            # have overwritten it, so reset it.
            if lengthA is not None:
                self.lengthA = lengthA
                lengthA_set = True
            if lengthB is not None:
                self.lengthB = lengthB
                lengthB_set = True

        if anchorA is not None and groundAnchorA is not None and lengthA is None:
            d1 = self.anchorA - self.groundAnchorA
            self.lengthA = d1.length
            lengthA_set = True

        if anchorB is not None and groundAnchorB is not None and lengthB is None:
            d2 = self.anchorB - self.groundAnchorB
            self.lengthB = d2.length
            lengthB_set=True

        if ratio is not None:
            # Ratio too small?
            assert(self.ratio > globals()['b2_epsilon'])
            if lengthA_set and lengthB_set and maxLengthA is None and maxLengthB is None:
                C = self.lengthA + self.ratio * self.lengthB
                self.maxLengthA = C - self.ratio * b2_minPulleyLength
                self.maxLengthB = (C - b2_minPulleyLength) / self.ratio
%}
/*
TODO:
Note on the above:
    assert(self.ratio > globals()['b2_epsilon']) # Ratio too small
Should really just be:
    assert(self.ratio > b2_epsilon) # Ratio too small 
But somehow SWIG is renaming b2_epsilon to FLT_EPSILON after it sees the #define,
but does not export the FLT_EPSILON symbol to Python. It then crashes once it reaches
this point. So, figure out a way around this, somehow.
*/


/**** RevoluteJointDef ****/
%extend b2RevoluteJointDef {
    %pythoncode %{
        def __set_anchor(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
        def __get_anchor(self):
            if self.bodyA:
                return self.bodyA.GetWorldPoint(self.localAnchorA)
            if self.bodyB:
                return self.bodyB.GetWorldPoint(self.localAnchorB)
            raise ValueError('Neither body was set; unable to get world point.')
        anchor = property(__get_anchor, __set_anchor, 
                doc="""The anchor in world coordinates.
                    Getting the property depends on either bodyA and localAnchorA or 
                    bodyB and localAnchorB.
                    Setting the property requires that both bodies be set.""")
    %}
}

%feature("shadow") b2RevoluteJointDef::b2RevoluteJointDef() %{
    def __init__(self, **kwargs):
        _Box2D.b2RevoluteJointDef_swiginit(self,_Box2D.new_b2RevoluteJointDef())
        _init_jointdef_kwargs(self, **kwargs)
        if self.bodyA and self.bodyB and 'referenceAngle' not in kwargs:
            self.referenceAngle = self.bodyB.angle - self.bodyA.angle
%}

/**** WeldJointDef ****/
%extend b2WeldJointDef {
    %pythoncode %{
        def __set_anchor(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
        def __get_anchor(self):
            if self.bodyA:
                return self.bodyA.GetWorldPoint(self.localAnchorA)
            if self.bodyB:
                return self.bodyB.GetWorldPoint(self.localAnchorB)
            raise ValueError('Neither body was set; unable to get world point.')
        anchor = property(__get_anchor, __set_anchor, 
                doc="""The anchor in world coordinates.
                    Getting the property depends on either bodyA and localAnchorA or 
                    bodyB and localAnchorB.
                    Setting the property requires that both bodies be set.""")
    %}
}

%feature("shadow") b2WeldJointDef::b2WeldJointDef() %{
    def __init__(self, **kwargs):
        _Box2D.b2WeldJointDef_swiginit(self,_Box2D.new_b2WeldJointDef())
        _init_jointdef_kwargs(self, **kwargs)
        if self.bodyA and self.bodyB and 'referenceAngle' not in kwargs:
            self.referenceAngle = self.bodyB.angle - self.bodyA.angle
%}

/**** Add some of the functionality that Initialize() offers for joint definitions ****/
/**** RopeJointDef ****/
%extend b2RopeJointDef {
    %pythoncode %{
        def __set_anchorA(self, value):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            self.localAnchorA=self.bodyA.GetLocalPoint(value)
        def __set_anchorB(self, value):
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            self.localAnchorB=self.bodyB.GetLocalPoint(value)
        def __get_anchorA(self):
            if not self.bodyA:
                raise ValueError('bodyA not set.')
            return self.bodyA.GetWorldPoint(self.localAnchorA)
        def __get_anchorB(self):
            if not self.bodyB:
                raise ValueError('bodyB not set.')
            return self.bodyB.GetWorldPoint(self.localAnchorB)

        anchorA = property(__get_anchorA, __set_anchorA, 
                doc="""Body A's anchor in world coordinates.
                    Getting the property depends on both bodyA and localAnchorA.
                    Setting the property requires that bodyA be set.""")
        anchorB = property(__get_anchorB, __set_anchorB, 
                doc="""Body B's anchor in world coordinates.
                    Getting the property depends on both bodyB and localAnchorB.
                    Setting the property requires that bodyB be set.""")
    %}
}

%feature("shadow") b2RopeJointDef::b2RopeJointDef() %{
    def __init__(self, **kwargs):
        _Box2D.b2RopeJointDef_swiginit(self,_Box2D.new_b2RopeJointDef())
        _init_jointdef_kwargs(self, **kwargs)
%}

/**** Add some of the functionality that Initialize() offers for joint definitions ****/
/**** MotorJointDef ****/
%extend b2MotorJointDef {
    %pythoncode %{

    %}
}

%feature("shadow") b2MotorJointDef::b2MotorJointDef() %{
    def __init__(self, bodyA=None, bodyB=None, **kwargs):
        _Box2D.b2MotorJointDef_swiginit(self,_Box2D.new_b2MotorJointDef())
        _init_jointdef_kwargs(self, bodyA=bodyA, bodyB=bodyB, **kwargs)
        if bodyA is not None and bodyB is not None:
            if not kwargs:
                self.Initialize(bodyA, bodyB)
%}

%extend b2MotorJoint {
public:
    %pythoncode %{
        # Read-write properties
        maxForce = property(__GetMaxForce, __SetMaxForce)
        maxTorque = property(__GetMaxTorque, __SetMaxTorque)
        linearOffset = property(__GetLinearOffset, __SetLinearOffset)
        angularOffset = property(__GetAngularOffset, __SetAngularOffset) 
    %}
}

%rename(__GetMaxForce) b2MotorJoint::GetMaxForce;
%rename(__SetMaxForce) b2MotorJoint::SetMaxForce;
%rename(__GetMaxTorque) b2MotorJoint::GetMaxTorque;
%rename(__SetMaxTorque) b2MotorJoint::SetMaxTorque;
%rename(__GetLinearOffset) b2MotorJoint::GetLinearOffset;
%rename(__SetLinearOffset) b2MotorJoint::SetLinearOffset;
%rename(__GetAngularOffset) b2MotorJoint::GetAngularOffset;
%rename(__SetAngularOffset) b2MotorJoint::SetAngularOffset;

/**** Hide the now useless enums ****/
%ignore e_atLowerLimit;
%ignore e_atUpperLimit;
%ignore e_distanceJoint;
%ignore e_equalLimits;
%ignore e_frictionJoint;
%ignore e_gearJoint;
%ignore e_inactiveLimit;
%ignore e_lineJoint;
%ignore e_mouseJoint;
%ignore e_prismaticJoint;
%ignore e_pulleyJoint;
%ignore e_revoluteJoint;
%ignore e_unknownJoint;
%ignore e_weldJoint;
%ignore e_motorJoint;;
