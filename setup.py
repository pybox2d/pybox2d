#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Setup script for pybox2d.

For installation instructions, see INSTALL.

Basic install steps:
 python setup.py build

If that worked, then:
 python setup.py install
"""

import os
import sys
from glob import glob

__author__='Ken Lauer'
__license__='zlib'

import setuptools
from setuptools import (setup, Extension)

# release version number
box2d_version  = '2.3'
release_number = 10

# create the version string
version_str = "%s.%s" % (box2d_version, release_number)

# setup some paths and names
library_base='library' # the directory where the egg base will be for setuptools develop command
library_name='Box2D'   # the final name that the library should end up being
library_path=os.path.join(library_base, library_name) # library/Box2D (e.g.)
source_dir='Box2D' # where all of the C++ and SWIG source resides
swig_source='Box2D.i' # the main SWIG source file
use_kwargs=True # whether or not to default creating kwargs for all functions


def write_init():
    # read in the license header
    license_header = open(os.path.join(source_dir, 'pybox2d_license_header.txt')).read()

    init_source = [
        "from .%s import *" % library_name,
        "__version__ = '%s'" % version_str,
        "__version_info__ = (%s,%d)" % (box2d_version.replace('.', ','), release_number),
        "__license__ = '%s'" % __license__ ,
        ]

    # and create the __init__ file with the appropriate version string
    f=open(os.path.join(library_path, '__init__.py'), 'w')
    f.write(license_header)
    f.write( '\n'.join(init_source) )
    f.close()

source_paths = [
    os.path.join(source_dir, 'Dynamics'),
    os.path.join(source_dir, 'Dynamics', 'Contacts'),
    os.path.join(source_dir, 'Dynamics', 'Joints'),
    os.path.join(source_dir, 'Common'),
    os.path.join(source_dir, 'Collision'),
    os.path.join(source_dir, 'Collision', 'Shapes'),
    ]

# glob all of the paths and then flatten the list into one
box2d_source_files = [os.path.join(source_dir, swig_source)] + \
    sum( [glob(os.path.join(path, "*.cpp")) for path in source_paths], [])

# arguments to pass to SWIG. for old versions of SWIG, -O (optimize) might not be present.
# Defaults:
# -O optimize, -includeall follow all include statements, -globals changes cvar->b2Globals
# -Isource_dir adds source dir to include path, -outdir library_path sets the output directory
# -small makes the Box2D_wrap.cpp file almost unreadable, but faster to compile. If you want
# to try to understand it for whatever reason, I'd recommend removing that option.
swig_arguments = \
        '-c++ -I%s -small -O -includeall -ignoremissing -w201 -globals b2Globals -outdir %s' \
        % (source_dir, library_path)

if use_kwargs:
    # turn off the warnings about functions that can't use kwargs (-w511)
    # and let the wrapper know we're using kwargs (-D_SWIG_KWARGS)
    swig_arguments += " -keyword -w511 -D_SWIG_KWARGS"

# depending on the platform, add extra compilation arguments. hopefully if the platform
# isn't windows, g++ will be used; -Wno-unused then would suppress some annoying warnings
# about the Box2D source.
if sys.platform in ('win32', 'win64'):
    extra_args=['-I.', '-fpermissive']
else:
    extra_args=['-I.', '-Wno-unused']

pybox2d_extension = Extension(
    'Box2D._Box2D', box2d_source_files, extra_compile_args=extra_args,
    language='c++')

LONG_DESCRIPTION = \
""" 2D physics library Box2D %s for usage in Python.

    After installing please be sure to try out the testbed demos.
    They require either pygame or pyglet and are available on the
    homepage or directly in this package.

    pybox2d homepage: https://github.com/pybox2d/pybox2d
    Box2D homepage: http://www.box2d.org
    """ % (box2d_version,)

CLASSIFIERS = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: zlib/libpng License",
    "Operating System :: Microsoft :: Windows",
    "Operating System :: MacOS :: MacOS X",
    "Operating System :: POSIX",
    "Programming Language :: Python",
    "Topic :: Software Development :: Libraries :: Python Modules",
    "Topic :: Software Development :: Libraries :: pygame",
    ]

write_init()

print(setuptools.find_packages('library'))
setup_dict = dict(
    name             = "Box2D",
    version          = version_str,
    author           = "Ken Lauer",
    author_email     = "sirkne at gmail dot com",
    description      = "Python Box2D",
    license          = "zlib",
    url              = "http://github.com/pybox2d/pybox2d",
    long_description = LONG_DESCRIPTION,
    package_dir      = {'': 'library'},
    packages         = setuptools.find_packages(library_base),
    test_suite       = 'tests',
    options          = { 'build_ext': { 'swig_opts' : swig_arguments },
                         'egg_info' : { 'egg_base' : library_base },
                        },
    ext_modules      = [ pybox2d_extension ],
    include_package_data=True,
    )

# run the actual setup from distutils
setup(**setup_dict)
