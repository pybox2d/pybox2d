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

import setuptools
from setuptools import (setup, Extension)
from setuptools.command.build_ext import build_ext
from setuptools.command.build_py import build_py as _build_py


try:
    # Attempt to build in parallel and save my time
    from numpy.distutils.ccompiler import CCompiler_compile
    import distutils.ccompiler
    distutils.ccompiler.CCompiler.compile = CCompiler_compile
except ImportError:
    pass

# release version number
box2d_version  = '2.4'
release_number = 0

# create the version string
version_str = "%s.%s" % (box2d_version, release_number)

# setup some paths and names
library_base='library' # the directory where the egg base will be for setuptools develop command
library_path=os.path.join(library_base, 'Box2D')

source_dir = 'src'
swig_source_dir = os.path.join(source_dir, 'swig')

box2d_library_root = os.path.join(source_dir, 'box2d')
box2d_library_source = os.path.join(box2d_library_root, 'src')
box2d_library_include = os.path.join(box2d_library_root, 'include')


def write_init():
    # read in the license header
    license_header = open(os.path.join(source_dir, 'pybox2d_license_header.txt')).read()

    init_source = [
        "from .Box2D import *",  # the swig-generated source
        "__version__ = '%s'" % version_str,
        "__version_info__ = (%s,%d)" % (box2d_version.replace('.', ','), release_number),
        "__license__ = 'zlib'",
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

pybox2d_extension = Extension(
    'Box2D._Box2D', box2d_source_files,
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


class BuildPy(_build_py):
    def run(self):
        self.run_command("build_ext")
        return super(BuildPy, self).run()


class BuildExt(build_ext):
    """A custom build extension for adding compiler-specific options."""
    compile_opts = {
        'msvc': ['/DUSE_EXCEPTIONS'],
        'unix': ['-DUSE_EXCEPTIONS', '-Wno-unused', '-std=c++11'],
        'darwin': ['-stdlib=libc++', '-mmacosx-version-min=10.7'],
    }
    link_opts = {
        'msvc': [],
        'unix': [],
        'darwin': ['-lstdc++'],
    }

    if sys.platform == 'darwin':
        # compiler_type will be reported as 'unix' below
        compile_opts['unix'].extend(compile_opts['darwin'])
        link_opts['unix'].extend(link_opts['darwin'])

    def build_extensions(self):
        compiler_type = self.compiler.compiler_type
        opts = self.compile_opts.get(compiler_type, [])
        link_opts = self.link_opts.get(compiler_type, [])
        for ext in self.extensions:
            ext.extra_compile_args = opts
            ext.extra_link_args = link_opts
        build_ext.build_extensions(self)


setup_dict = dict(
    name             = "Box2D",
    version          = version_str,
    author           = "Ken Lauer",
    author_email     = "sirkne@gmail.com",
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
    cmdclass         = {'build_ext': BuildExt,
                        'build_py' : BuildPy},
    ext_modules      = [ pybox2d_extension ],
    include_package_data=True,
    )

# run the actual setup from distutils
setup(**setup_dict)
