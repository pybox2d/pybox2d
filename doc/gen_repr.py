import Box2D as box2d
import inspect

classes = [c for c in dir(box2d) 
            if c[0:2]=='b2' and inspect.isclass(getattr(box2d, c))]

def evaluate(name):
    """Return a rather verbose string representation of a joint"""
    ignoreList = ('this', 'thisown', 'm_next', 'm_prev', 
                'prevcontroller', 'nextcontroller', 'nextbody', 'prevbody', 'prev', 'next',
                'world', )
    ignoreAccessor = ('prev', 'next', 'world', 'body1', 'body2', 'joint1',
                  'joint2', 'inverse', 'nextedge', 'prevedge',)
    #longList=('fixtures', 'bodies', 'contacts', 'joints', 'inverse')
    def checkArgs(prop):
        # uses a really stupid method of determining if it's really just an accessor
        # or if it's used like GetLocalPoint(). introspection like func_code doesn't seem
        # to work with swig
        doc = prop.__doc__
        if not doc:
            print '!!!!! no docstring', name, prop 
            return False
        if doc.find("->") == -1:
            return False
        lines = doc.split("->")
        if lines[0].find(",") > -1:
            return False
        return True
    def checkProperty(prop):
        if prop.lower() in ignoreList: return False
        if prop.startswith("__"): return False
        if prop.startswith("e_"): return False
        if callable(getattr(_class, prop)): 
            if prop.startswith("Get"):
                if prop[3:].lower() in ignoreAccessor: return False
            elif prop.startswith("Is"):
                if prop[2:].lower() in ignoreAccessor: return False
            else:
                return False
            # todo: see if arguments can be determined through introspection
            if not checkArgs(getattr(_class, prop)):
                return False
            prop += "()"
        elif isinstance(getattr(_class, prop), (dict, int, float, list)):
            return False
        return prop
    _class = getattr(box2d, name)
    props = []

    property_list = []
    accessor_list = []
    for member in dir(_class):
        _type = getattr(_class, member)
        if isinstance(_type, property) or _type is None:
            member = checkProperty(member)
            if member:
                property_list.append(member)
        else:
            member = checkProperty(member)
            if member:
                accessor_list.append(member)

    for prop in property_list:
        is_name = ('Is' + prop.capitalize() + '()')
        get_name = ('Get' + prop.capitalize() + '()')
        if is_name in accessor_list:
            accessor_list.remove(is_name)
            raise ('!!remove %s.%s' % (name, is_name))
        if get_name in accessor_list:
            accessor_list.remove(get_name)
            print ('!!remove %s.%s' % (name, get_name))

    all_info = sorted(property_list) + sorted(accessor_list)
    if not all_info:
        return '"%s()"' % name

    if accessor_list:
        raise ValueError('Get rid of these accessors: %s.(%s)' % (name, ','.join(accessor_list)))

    prop_str=','.join(["'%s'" % prop for prop in sorted(property_list)])
    ret_string="""_format_repr(self, [%s]) """ % (prop_str)
    return ret_string    

print r"""
%pythoncode %{
_format_recursed=0
import pprint
def _format_repr(item, props, indent_amount=4, max_level=4, max_str_len=250, max_sub_lines=10):
    global _format_recursed
    _format_recursed+=1
    indent_str=' ' * (_format_recursed*indent_amount) 
    ret=['%s(' % item.__class__.__name__]

    #ret.append(str(_format_recursed))
    if _format_recursed > max_level:
        _format_recursed-=1
        return indent_str + '(*recursion*)'
    
    for prop in props:
        try:
            s=repr(getattr(item, prop))
        except Exception as ex:
            s='(*repr failed: %s*)' % ex

        if s.count('\n') > max_sub_lines:
            length=0
            for i, line in enumerate(s.split('\n')[:max_sub_lines]):
                length+=len(line)
                if length > max_str_len:
                    ending_delim=''
                    for j in s[::-1]:
                        if j in ')]}':
                            ending_delim+=j
                        else:
                            break
                    ret[-1]+='(...) %s' % ending_delim[::-1]
                    break

                if i==0:
                    ret.append('%s=%s' % (prop, line))
                else:
                    ret.append(line) 
        else:
            if '\n' in s:
                toadd=s.split('\n')
                ret.append('%s=%s' % (prop, toadd[0]))
                ret.extend(toadd[1:])
            else:
                ret.append('%s=%s,' % (prop, s))
    
    separator='\n%s' % indent_str
    _format_recursed-=1
    
    if len(ret) <= 3:
        ret[-1]+=')'
        return [''.join(ret)]
    else:
        ret.append(')')
        return separator.join(ret)
%}
"""

swig_template=r"""%%extend %s {
    %%pythoncode %%{
        def __repr__(self):
            return %s
    %%}
}"""


for c in classes:
    print swig_template % (c, evaluate(c))
#    break
