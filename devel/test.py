classname = "b2DebugDraw"
gets = "GetFlags SetFlags ClearFlags AppendFlags".split(" ")
sets = "".split(" ")
kwargs = True

# remove duplicates
gets = list(set(gets))
sets = list(set(sets))

renames = ["%%rename(__%s) %s::%s;" % (s, classname, s) for s in gets+sets
                    if s not in ('GetAnchorA', 'GetAnchorB', '')]

gets_mod=[]
for s in gets:
    if s[:3]=="Get":
        gets_mod.append(s[3:])
    elif s[:2]=="Is":
        gets_mod.append(s[2:])
    else:
        gets_mod.append(s)

sets_mod=[]
for s in sets:
    if s[:3]=="Set":
        sets_mod.append(s[3:])
    else:
        sets_mod.append(s)

done = []
getter_setter = []
getter = []

for i, s in enumerate(gets_mod):
    if s in sets_mod:
        orig_set=sets[ sets_mod.index(s) ]
        orig_get = gets[i]
        getter_setter.append( (s, orig_get, orig_set) )
        sets[sets_mod.index(s)] = None
    else:
        getter.append( (s, gets[i]) )

setter = [s for s in sets if s is not None]

if kwargs:
    print '''
    /**** %s ****/
    %%extend %s {
    public:
        %%pythoncode %%{
            def __init__(self, **kwargs): 
                """__init__(self, **kwargs) -> %s """
                _Box2D.%s_swiginit(self,_Box2D.new_%s())
                for key, value in kwargs.items():
                    setattr(self, key, value)

            # Read-write properties
''' % tuple([classname[2:]] + [classname]*4)
else:
    print '''
    /**** %s ****/
    %%extend %s {
    public:
        %%pythoncode %%{
            # Read-write properties
''' % (classname[2:], classname)

for name, g, s in getter_setter:
    newname= name[0].lower() + name[1:]
    print "            %s = property(__%s, __%s)" % (newname, g, s)

print "            # Read-only"
for name, g in getter:
    newname= name[0].lower() + name[1:]
    if newname in ('anchorA', 'anchorB'):
        print "            %s = property(lambda self: self._b2Joint__%s(), None)" % (newname, name)
    else:
        print "            %s = property(__%s, None)" % (newname, g)

print "            # Write-only"
for s in setter:
    if not s: continue
    if s[:3]=='Set':
        name = s[3:] 
    else:
        name = s
    newname= name[0].lower() + name[1:]
    print "            %s = property(None, __%s)" % (newname, s)

print """
        %}
    }
"""
print "   ",
print "\n    ".join(renames)
