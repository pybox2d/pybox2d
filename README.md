[![Build Status](https://travis-ci.org/pybox2d/pybox2d.svg?branch=master)](https://travis-ci.org/pybox2d/pybox2d) [![Coverage Status](https://coveralls.io/repos/pybox2d/pybox2d/badge.svg?branch=master&service=github)](https://coveralls.io/github/pybox2d/pybox2d?branch=master)

pybox2d
-------
2D Game Physics for Python

https://github.com/pybox2d/pybox2d

How to get it
-------------

pybox2d is available on conda-forge with the package name `pybox2d`.
To create a new conda environment with pybox2d, run the following:

```bash
$ conda create -n pybox2d -c conda-forge python=3.6 pybox2d
$ conda activate pybox2d
```

Recent builds should be available for Windows, Linux, and OS X, with Python
3.6, 3.7, and 3.8.  More detailed installation instructions are available in
[INSTALL.md](INSTALL.md).

What is it?
-----------
pybox2d is a 2D physics library for your games and simple simulations. It's
based on the Box2D library, written in C++. It supports several shape types
(circle, polygon, thin line segments), and quite a few joint types (revolute,
prismatic, wheel, etc.).

Getting Started
---------------
For installation or building instructions, see [INSTALL.md](INSTALL.md). Check
out the testbed [examples](examples) to see what pybox2d can do. Then take a
look at the 
[getting started manual](https://github.com/pybox2d/pybox2d/wiki/manual)
located on the pybox2d wiki.

Bugs
----
Please submit any bugs that you find to the 
[issue tracker](https://github.com/pybox2d/pybox2d/issues).
