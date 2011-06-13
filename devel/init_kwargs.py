from all_classes import *

print("""
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

%pythoncode %{
    def _init_kwargs(self, **kwargs):
        for key, value in list(kwargs.items()):
            try:
                setattr(self, key, value)
            except Exception as ex:
                raise ex.__class__('Failed on kwargs, class="%s" key="%s": %s' 
                            % (self.__class__.__name__, key, ex))
%}
""")

extend_string="""
%%feature("shadow") %s::%s() {
    def __init__(self, **kwargs):
        _Box2D.%s_swiginit(self,_Box2D.new_%s())
        _init_kwargs(self, **kwargs)
}
"""

director_string="""
%%feature("shadow") %s::%s() {
    def __init__(self, **kwargs):
        if self.__class__ == %s:
            _self = None
        else:
            _self = self
        _Box2D.%s_swiginit(self,_Box2D.new_%s(_self, ))
        _init_kwargs(self, **kwargs)
}
"""
all_classes.remove('b2World')

director_classes = ['b2ContactFilter', 'b2ContactListener', 'b2QueryCallback', 'b2DebugDraw', 'b2DestructionListener' ]
abstract_classes = ['b2Joint', 'b2Shape', 'b2RayCastCallback', 'b2Contact']
for c in abstract_classes:
    # print(director_string % tuple([c]*4))
    all_classes.remove(c)
for c in director_classes:
    print(director_string % tuple([c]*5))
    all_classes.remove(c)
for c in all_classes:
    print(extend_string % tuple([c]*4))
