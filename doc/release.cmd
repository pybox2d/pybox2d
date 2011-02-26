@echo off
@echo --- Building ---
cd ..
call build
cd doc
cd Doxygen
@echo --- Doxygen ---
call generate
cd ..

@echo --- Epydoc ---
python gen_epydoc.py

@echo --- Adding the files to the SVN ---
svn -q add doxygen/html_output/*
svn -q add doxygen/xml_output/*
svn -q add epydoc/*

@echo --- Recreating reprs since docstrings are now set ---
python -c "lines=open('../Box2D/pybox2d_license_header.txt', 'rt').readlines(); open('../Box2D/Box2D_printing.i', 'wt').writelines([line.replace('#', '//') for line in lines])"
python gen_repr.py >> ..\Box2D\Box2D_printing.i

@echo --- Final build ---
cd ..
call build
