rem set DOXYGEN_PATH=c:\mingw\doxygen\bin
set DOXYGEN_PATH=d:\dev\doxygen\bin
set PYTHON_PATH=c:\python26

%DOXYGEN_PATH%/doxygen.exe
%PYTHON_PATH%/python.exe doxy2swig.py xml_output/index.xml ../../Box2D/Box2D_doxygen.i
