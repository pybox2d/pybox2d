### Install pre-built conda package (it's easy!)
------------------------------------------------
1. Install miniconda3. Download it from
   [here](http://conda.pydata.org/miniconda.html)
2. Create a new environment (named py34 here) and activate it:

    ```bash
    $ conda create -n py34 python=3.4
    $ source activate py34
    ```
3. Install Box2D from my channel

    ```bash
    $ conda install -c https://conda.anaconda.org/kne pybox2d
    ```

    Recent builds should be available for Windows, Linux, and OS X, with Python
    2.7, 3.3, 3.4 and 3.5.

4. Alternatively, you can build pybox2d from its source code. You should only
   really do this if you want the latest features not available in the
   release or if you want to help contribute to pybox2d. See the section below
   corresponding to your operating system for more instructions on how to do
   this.

### The testbed examples
------------------------
1. If using the conda packages, install a backend such as pygame to use as a
   renderer. I have packages for pygame and pygame_sdl2, the latter of which
   works better on OS X currently.

    ```bash
    $ source activate py34
    $ conda install -c https://conda.anaconda.org/kne pygame_sdl2
    ```
    
    | Backend        | Install                                                       | Homepage                             |
    | -------------  | ------------------------------------------------------------- | ------------------------------------ |
    | pygame         | `conda install -c https://conda.anaconda.org/kne pygame`      | http://pygame.org                    |  
    | pygame_sdl2    | `conda install -c https://conda.anaconda.org/kne pygame_sdl2` | https://github.com/renpy/pygame_sdl2 |
    | pyqt4          | `conda install pyqt4`                                         | https://www.riverbankcomputing.com/  |
    | pyglet         | `pip install pyglet`                                          | http://pyglet.org                    |
    | opencv         | `pip install opencv`                                          | http://opencv.org                    |

2. Download the latest release to get the examples: 
    [releases](https://github.com/pybox2d/pybox2d/releases)

    Alternatively, if you have git installed, clone it instead:
    ```bash
    # The 2.3.1 release
    $ git clone https://github.com/pybox2d/pybox2d -b 2.3.1
    # Or the latest development master branch
    $ git clone https://github.com/pybox2d/pybox2d
    ```

3. Run an example with the desired backend:
    ```bash
    $ cd pybox2d

    # List all of the examples available:
    $ ls examples/*.py

    # Try the web example:
    $ python -m examples.web --backend=pygame
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
