### Install pre-built conda package (it's easy!)
------------------------------------------------
1. Install miniconda3. Download it from
   [here](http://conda.pydata.org/miniconda.html)
2. Create a new environment (named py34 here) and activate it:

    ```bash
    $ conda create -n pybox2d -c conda-forge python=3.6 pybox2d pyglet
    $ conda activate pybox2d
    ```

    Recent builds should be available for Windows, Linux, and OS X, with Python
    3.6, 3.7, and 3.8.

3. Alternatively, you can build pybox2d from its source code. You should only
   really do this if you want the latest features not available in the
   release or if you want to help contribute to pybox2d. See the section below
   corresponding to your operating system for more instructions on how to do
   this.

### The testbed examples
------------------------
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

### Simple examples

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

### Building from source: Linux
--------------------------------
1. Download and install the latest version of SWIG (preferably 3.0+) with 
   your package manager.

   If you are using Ubuntu, you can install it via Synaptic Package Manager
   (package name 'swig'). You will also need to install the python-dev package,
   and build-essential. Finally, you'll need python-pygame if you want to run
   the testbed.

    ```bash
    $ sudo apt-get install build-essential python-dev swig python-pygame git
    ```

2. Clone the git repository

    ```bash
    $ git clone https://github.com/pybox2d/pybox2d
    ```

3. Build and install the pybox2d library

    ```bash
    $ python setup.py build

    # Assuming everything goes well...
    $ sudo python setup.py install
    ```

### Building from source: Windows
-----------
1. Install MinGW and then MSYS so that you can compile Box2D and pybox2d.
   Alternatively, install the correct version of Microsoft Visual Studio for
   your version of Python.
2. Install SWIG for making the Python wrapper. Install it in a location in your
   PATH, or add the SWIG directory to your PATH.

3. Clone the source from the git repository:

    ```bash
    $ git clone https://github.com/pybox2d/pybox2d
    ```

4. Run MSYS and locate your pybox2d directory

    ```bash
    $ cd /c/path/to/pybox2d
    ```

5. Build and install pybox2d

    ```bash
    $ python setup.py build
    $ python setup.py install
    ```

### Building from source: OS X
--------
1. Install homebrew from http://brew.sh/
2. Install SWIG, which wraps the C++ library. From a terminal window:

    ```bash
    $ brew install swig
    ```

3. Clone the source from the git repository:

    ```bash
    $ git clone https://github.com/pybox2d/pybox2d pybox2d_dev
    $ cd pybox2d_dev
    ```

4. Build and install pybox2d

    ```bash
    $ python setup.py build

    # Assuming you're using either Python from conda or brew Python,
    # you should be able to install without superuser privileges:
    $ python setup.py install

    # For development purposes, it may be more convenient to do a develop
    # install instead
    $ python setup.py develop
    ```
