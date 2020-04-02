### Note
--------

This building from source documentation is likely out-of-date.

Please consider using conda and installing via conda-forge.


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
