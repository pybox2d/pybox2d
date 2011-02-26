from __future__ import print_function
import glob
import re
import os
from all_classes import *

files = glob.glob('../Box2D/Box2D_*.i')
classes = {}
ignore_files = [
        'Box2D_kwargs.i', 
        'Box2D_dir.i', 
        ]

def find_extended(path):
    f = open(path, "r")
    fn = os.path.split(path)[1]
    for line in f.readlines():
        m=re.search('%extend\s*(.*)\s*{', line)
        if m:
            cls=m.groups()[0].strip()
            if cls in classes:
                if fn not in classes[cls]:
                    classes[cls].append(fn)
            else:
                classes[cls] = [fn]

    f.close()

for file in files:
    if os.path.split(file)[1] not in ignore_files:
        find_extended(file)

print("%19s  %s" % ('Class', 'Extended in'))
remaining=list(all_classes)
for key, value in list(classes.items()):
    print("%20s %s" % (key, ', '.join(value)))
    remaining.remove(key)

ignore_unmodified=[s for s in remaining if s[-3:] == 'Def']
#ignore_unmodified += []

print()
print("Unmodified classes")
for cls in remaining:
    if cls not in ignore_unmodified:
        print(cls)
