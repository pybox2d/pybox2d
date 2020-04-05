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

try:
    # Attempt to build in parallel and save my time
    from numpy.distutils.ccompiler import CCompiler_compile
    import distutils.ccompiler
    distutils.ccompiler.CCompiler.compile = CCompiler_compile
except ImportError:
    pass

# release version number
box2d_version  = '2.3'
release_number = 10

# create the version string
version_str = "%s.%s" % (box2d_version, release_number)

# setup some paths and names
library_base='library' # the directory where the egg base will be for setuptools develop command
library_name='Box2D'   # the final name that the library should end up being
library_path=os.path.join(library_base, library_name)

source_dir = 'src'
swig_source_dir = os.path.join(source_dir, 'swig')

box2d_library_root = os.path.join(source_dir, 'box2d')
box2d_library_source = os.path.join(box2d_library_root, 'src')
box2d_library_include = os.path.join(box2d_library_root, 'include')


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
    os.path.join(box2d_library_source),
    os.path.join(box2d_library_source, 'dynamics'),
    os.path.join(box2d_library_source, 'rope'),
    os.path.join(box2d_library_source, 'common'),
    os.path.join(box2d_library_source, 'collision'),
]

box2d_source_files = [os.path.join(swig_source_dir, 'Box2D.i')]
box2d_source_files.extend(
    sum( [glob(os.path.join(path, "*.cpp")) for path in source_paths], [])
)

# arguments to pass to SWIG
swig_arguments = ['-c++']
# add the include path
swig_arguments.append('-I' + box2d_library_include)
# -small makes the Box2D_wrap.cpp file almost unreadable, but faster to compile. If you want
# to try to understand it for whatever reason, I'd recommend removing that option.
# swig_arguments.append('-small')
# -O include some optimizations
swig_arguments.append('-O')
# Follow all include statements
swig_arguments.append('-includeall')
# swig may fail with "unable to find Python.h", for example
swig_arguments.append('-ignoremissing')

# Enable b2_settings.h remapping of b2Assert -> throw python exception
swig_arguments.append('-DUSE_EXCEPTIONS')
# Change cvar->b2Globals
swig_arguments.append('-globals b2Globals')
# Sets the output directory
swig_arguments.append('-outdir {}'.format(library_path))

# let the wrapper know we're using kwargs
swig_arguments.append('-keyword')
# turn off the warnings about functions that can't use kwargs (-w511)
swig_arguments.append('-w511')
swig_arguments.append('-D_SWIG_KWARGS')

# depending on the platform, add extra compilation arguments. hopefully if the platform
# isn't windows, g++ will be used; -Wno-unused then would suppress some annoying warnings
# about the Box2D source.
if sys.platform in ('win32', 'win64'):
    extra_compile_args=['-fpermissive']
    extra_link_args = []
elif sys.platform in ('darwin', ):
    extra_compile_args=['-Wno-unused', '-stdlib=libc++']
    extra_link_args = []
else:
    extra_compile_args=['-Wno-unused']
    extra_link_args = ['-lstdc++']

# Use C++11 standard libary
extra_compile_args.append('-std=c++11')
# Enable b2_settings.h remapping of b2Assert -> throw python exception
extra_compile_args.append('-DUSE_EXCEPTIONS')
# Include debug symbols
# extra_args.append('-g')

pybox2d_extension = Extension(
    'Box2D._Box2D', box2d_source_files,
    extra_compile_args=extra_compile_args,
    extra_link_args=extra_link_args,
    include_dirs=[box2d_library_source, box2d_library_include],
    language='c++11')

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
    options          = {'build_ext': {'swig_opts': ' '.join(swig_arguments)},
                        'egg_info': {'egg_base': library_base},
                        },
    ext_modules      = [ pybox2d_extension ],
    include_package_data=True,
    )

# run the actual setup from distutils
setup(**setup_dict)
