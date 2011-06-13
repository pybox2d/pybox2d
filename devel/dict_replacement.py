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

    def _dir_filter(self):
        # Using introspection, mimic dir() by adding up all of the __dicts__
        # for the current class and all base classes (type(self).__mro__ returns
        # all of the classes that make it up)
        # Basically filters by:
        # __x__ OK
        # __x bad
        # _classname bad
        def check(s):
            if s[:2]=='__':
                if s[-2:]=='__':
                    return True
                else:
                    return False
            else:
                for typename in typenames:
                    if typename in s:
                        return False
                return True
        
        keys=sum([c.__dict__.keys() for c in type(self).__mro__], [])
        typenames = ["_%s" % c.__name__ for c in type(self).__mro__]
        ret=[s for s in list(set(keys)) if check(s)]
        ret.sort()
        return ret

%}
""")

extend_string="""
%%extend %s {
    %%pythoncode %%{
        __dir__ = _dir_filter
    %%}
}
"""

for c in all_classes:
    print(extend_string % c)
