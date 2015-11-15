@echo off
set LC_ALL=en_US
set EDITOR=c:\vim72\vim.exe
set PYTHON_PATH=C:\python26\
set SWIG_PATH=C:\swigwin-1.3.40\
set PATH=%PATH%;%PYTHON_PATH%;%SWIG_PATH%
echo Using Python in %PYTHON_PATH%
echo Checking version...
echo ---
python.exe -V
echo ---
echo Using SWIG in %SWIG_PATH%
echo Checking version...
echo ---
swig.exe -version
echo ---
echo Type 'setup.py build', and then 'setup.py install' to install.
