#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest

class testBasic (unittest.TestCase):
#    def setUp(self):
#        pass

    def test_import(self):
        try:
            import Box2D
        except ImportError as s:
            self.fail("Unable to import Box2D library (%s)" % s)

if __name__ == '__main__':
    unittest.main()

