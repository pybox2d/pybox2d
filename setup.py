#!/usr/bin/env python
"""
Setup script for pybox2d.

For installation instructions, see INSTALL.

You may have some luck with just this:

$ python -m pip install .
"""

import os
import pathlib
import sys
from glob import glob

import setuptools
from setuptools import setup, Extension
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

source_dir = pathlib.Path('src')
swig_source_dir = source_dir / 'swig'

box2d_library_root = source_dir / 'box2d'
pybox2d_include = source_dir / 'include'
box2d_library_source = box2d_library_root / 'src'
box2d_library_include = box2d_library_root / 'include'


def check_submodule():
    readme_path = box2d_library_root / "README.md"
    if not readme_path.exists():
        print(f"""
The box2d source was not found in: {box2d_library_source}

For future reference, it should have been cloned as a submodule:
$ git clone --recurse-submodules https://github.com/pybox2d/pybox2d

To initialize it now without recloning, run the following:
$ git submodule update --init
        """
        )
        sys.exit(1)
        

def write_init():
    # read in the license header
    license_header = open(source_dir / 'pybox2d_license_header.txt').read()

    init_source = [
        "from .Box2D import *",  # the swig-generated source
        f"__version__ = '{version_str}'",
        "__version_info__ = (%s,%d)" % (box2d_version.replace('.', ','), release_number),
        "__license__ = 'zlib'",
        ]

    # and create the __init__ file with the appropriate version string
    f=open(os.path.join(library_path, '__init__.py'), 'w')
    f.write(license_header)
    f.write( '\n'.join(init_source) )
    f.close()


check_submodule()

source_paths = [
    box2d_library_source,
    box2d_library_source / 'dynamics',
    box2d_library_source / 'rope',
    box2d_library_source / 'common',
    box2d_library_source / 'collision',
]

box2d_source_files = [swig_source_dir / 'Box2D.i']
box2d_source_files.extend(
    sum( [list(path.glob("*.cpp")) for path in source_paths], [])
)

# arguments to pass to SWIG
swig_arguments = ['-c++']
# add the include paths
swig_arguments.append(f'-I{box2d_library_include}')
# enable our user settings and add our pybox2d include path
swig_arguments.append('-DB2_USER_SETTINGS')
swig_arguments.append(f'-I{pybox2d_include}')
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

if not box2d_source_files:
    raise RuntimeError("No Box2D source files found; something went wrong.")

pybox2d_extension = Extension(
    'Box2D._Box2D', 
    box2d_source_files,
    include_dirs=[box2d_library_source, box2d_library_include, pybox2d_include],
    language='c++11',
)

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
        'msvc': ['/DUSE_EXCEPTIONS', '/DB2_USER_SETTINGS'],
        'unix': ['-DB2_USER_SETTINGS', '-DUSE_EXCEPTIONS', '-Wno-unused', '-std=c++11'],
        'darwin': ['-stdlib=libc++', '-mmacosx-version-min=10.7'],
    }
    link_opts = {
        'msvc': [],
        'unix': ['-lstdc++'],
        'darwin': [],
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
