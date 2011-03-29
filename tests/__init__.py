#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os, sys
from glob import glob

tests=glob(os.path.join(os.path.dirname(__file__),"*.py"))

#__all__ = [os.path.basename(file)[:-3] for file in files
#            if file!='__init__.py']

for test in tests:
    __import__(os.path.basename(test)[:-3], globals(), locals(), [], -1)
