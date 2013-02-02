set HOME=C:\Users\Ken\
set NAME="Ken Lauer"

cd ..
del /s /f /q build
C:\Python27\python.exe setup.py bdist_egg upload --identity=%NAME% --sign --quiet
C:\Python27\python.exe setup.py bdist_wininst --target-version=2.7 register upload --identity=%NAME% --sign --quiet
C:\Python27\python.exe setup.py sdist upload --identity=%NAME% --sign
cd devel
