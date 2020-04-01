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
3.6, 3.7, and 3.8.

What is it?
-----------
pybox2d is a 2D physics library for your games and simple simulations. It's
based on the Box2D library, written in C++. It supports several shape types
(circle, polygon, thin line segments), and quite a few joint types (revolute,
prismatic, wheel, etc.).

Getting Started
---------------
For building instructions, see [INSTALL.md](INSTALL.md). Check out the testbed
[examples](examples) to see what pybox2d can do. Then take a
look at the 
[getting started manual](https://github.com/pybox2d/pybox2d/wiki/manual)
located on the pybox2d wiki.

Bugs
----
Please submit any bugs that you find to the 
[issue tracker](https://github.com/pybox2d/pybox2d/issues).

Testbed examples
----------------

You can browse the testbed examples on GitHub
[here](https://github.com/pybox2d/pybox2d/tree/master/library/Box2D/examples)

1. Install a backend such as pygame or pyglet to use as a renderer.

    | Backend        | Install                                                       | Homepage                             |
    | -------------  | ------------------------------------------------------------- | ------------------------------------ |
    | pygame         | `pip install pygame`                                          | http://pygame.org                    |  
    | pyqt4          | `conda install pyqt4`                                         | https://www.riverbankcomputing.com/  |
    | pyglet         | `pip install pyglet` (or use conda-forge)                     | http://pyglet.org                    |
    | opencv         | `pip install opencv`                                          | http://opencv.org                    |

2. Run your first example with the pygame backend:
    ```bash
    # As a start, try the web example with the pygame backend:
    $ python -m Box2D.examples.web --backend=pygame
    ```

3. Take a look at the other examples, setting the backend as appropriate:
    ```bash
    $ python -m Box2D.examples.apply_force
    $ python -m Box2D.examples.body_types
    $ python -m Box2D.examples.box_cutter
    $ python -m Box2D.examples.breakable
    $ python -m Box2D.examples.bridge
    $ python -m Box2D.examples.bullet
    $ python -m Box2D.examples.cantilever
    $ python -m Box2D.examples.car
    $ python -m Box2D.examples.chain
    $ python -m Box2D.examples.character_collision
    $ python -m Box2D.examples.cloth
    $ python -m Box2D.examples.collision_filtering
    $ python -m Box2D.examples.collision_processing
    $ python -m Box2D.examples.confined
    $ python -m Box2D.examples.convex_hull
    $ python -m Box2D.examples.conveyor_belt
    $ python -m Box2D.examples.distance
    $ python -m Box2D.examples.edge_shapes
    $ python -m Box2D.examples.edge_test
    $ python -m Box2D.examples.gish_tribute
    $ python -m Box2D.examples.hello
    $ python -m Box2D.examples.liquid
    $ python -m Box2D.examples.mobile
    $ python -m Box2D.examples.motor_joint
    $ python -m Box2D.examples.one_sided_platform
    $ python -m Box2D.examples.pinball
    $ python -m Box2D.examples.pulley
    $ python -m Box2D.examples.pyramid
    $ python -m Box2D.examples.raycast
    $ python -m Box2D.examples.restitution
    $ python -m Box2D.examples.rope
    $ python -m Box2D.examples.settings
    $ python -m Box2D.examples.theo_jansen
    $ python -m Box2D.examples.tiles
    $ python -m Box2D.examples.time_of_impact
    $ python -m Box2D.examples.top_down_car
    $ python -m Box2D.examples.tumbler
    $ python -m Box2D.examples.vertical_stack
    $ python -m Box2D.examples.web
    ```

These framework examples are included in the distribution, but they are also
written in a way such that you can copy the `examples` directly and modify them
yourself.

For example, the following would be possible:

```bash
$ git clone https://github.com/pybox2d/pybox2d pybox2d
$ mkdir my_new_examples
$ cp -R pybox2d/library/Box2D/examples/* my_new_examples
$ cd my_new_examples
$ python web.py --backend=pygame
```

Simple examples
---------------

There are also some simple examples that are not weighed down by testbed architecture.
You can browse them on GitHub
[here](https://github.com/pybox2d/pybox2d/tree/master/library/Box2D/examples/simple)

These can also be run directly from your pybox2d installation:

```bash
$ python -m Box2D.examples.simple.simple_01
$ python -m Box2D.examples.simple.simple_02
```

A similar opencv-based example is here:
```bash
$ python -m Box2D.examples.simple_cv
```
