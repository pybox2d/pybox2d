#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from Box2D import b2Color

class testColor (unittest.TestCase):
    def checkAlmostEqual(self, v1, v2, msg, places=3):
        for i, (a, b) in enumerate(zip(v1, v2)):
            self.assertAlmostEqual(a, b, places=places, 
                    msg="(index %d) %s, a=%f b=%f from %s, %s" % (i, msg, a, b, v1, v2))

    def test_color(self):
        x, y, z = 1.0, 2.0, 3.0
        c1 = b2Color(x, y, z)
        c2 = b2Color(z, y, x)

        c = c1 + c2
        self.checkAlmostEqual(c, (x+z, y+y, z+x), msg='b2Color +')
        c = c1 - c2
        self.checkAlmostEqual(c, (x-z, y-y, z-x), msg='b2Color -')
        c = 2.0 * c1
        self.checkAlmostEqual(c, (x+x, y+y, z+z), msg='float * b2Color')
        c = c1 * 2.0
        self.checkAlmostEqual(c, (x+x, y+y, z+z), msg='b2Color * float')
        c = c1 / 2.0
        self.checkAlmostEqual(c, (x/2.0, y/2.0, z/2.0), msg='b2Color / float')

        c = c1.copy()
        c *= 2.0
        self.checkAlmostEqual(c, (x+x, y+y, z+z), msg='b2Color *= float')
        c = b2Color(c1)
        c /= 2.0
        self.checkAlmostEqual(c, (x/2.0, y/2.0, z/2.0), msg='b2Color /= float')
        c1 += (1.0, 1.0, 1.0)
        self.checkAlmostEqual(c1, (x+1, y+1, z+1), msg='b2Color +=')
        c1 -= (1.0, 1.0, 1.0)
        self.checkAlmostEqual(c1, (x, y, z), msg='b2Color -=')

        bytes=b2Color(1, 1, 1).bytes
        self.assertEqual(bytes, [255,255,255], msg='bytes (1,1,1)=>%s'%bytes)
        bytes=b2Color(0, 0, 0).bytes
        self.assertEqual(bytes, [0,0,0], msg='bytes (1,1,1)=>%s'%bytes)

        self.assertEqual(c1[0], x)
        self.assertEqual(c1[1], y)
        self.assertEqual(c1[2], z)

        c1.list = (x*2, y*2, z*2)
        self.checkAlmostEqual(c1, (x+x, y+y, z+z), msg='b2Color.list')

if __name__ == '__main__':
    unittest.main()


