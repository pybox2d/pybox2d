#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
import sys

class testBasic (unittest.TestCase):
#    def setUp(self):
#        pass

    def test_import(self):
        try:
            import Box2D
        except ImportError:
            self.fail("Unable to import Box2D library (%s)" % sys.exc_info()[1])

if __name__ == '__main__':
    unittest.main()

