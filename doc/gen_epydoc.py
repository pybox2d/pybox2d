import os

file='../library/Box2D/Box2D.py'

original_lines=open(file, 'rt').readlines()
lines=[line for line in original_lines
            if not ('thisown' in line and '_swig_property' in line)]

open(file, 'wt').writelines(lines)

os.system('python -m epydoc.cli --config=epydoc_config')

open(file, 'wt').writelines(original_lines)

