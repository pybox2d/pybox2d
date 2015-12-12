#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from Box2D import b2Vec2, b2Vec3, b2Mat22, b2Mat33

class testMatrix (unittest.TestCase):
    def checkAlmostEqual(self, v1, v2, msg):
        for a, b in zip(v1, v2):
            self.assertAlmostEqual(a, b, places=3,
                    msg="%s, a=%f b=%f from %s, %s" % (msg, a, b, v1, v2))

    def test_mat22_identity(self):
        i2 = b2Mat22()
        self.checkAlmostEqual(i2.col1, (1.0, 0.0), msg='mat22 col1')
        self.checkAlmostEqual(i2.col2, (0.0, 1.0), msg='mat22 col2')

    def test_matrix(self):
        x, y, z = 1.0, 2.0, 3.0
        v2 = b2Vec2(x, y)

        self.checkAlmostEqual(v2.skew, (-v2.y, v2.x), msg='skew')

        m2 = b2Mat22((x, y), (y, x))
        # Note that you can't do:
        # m2 = b2Mat22(col1=(x, y), col2=(y, x))
        # as SWIG will not allow the kwargs option to be used when there are multiple constructors

        m = m2 + m2
        self.checkAlmostEqual(m.col1, (x+x, y+y), msg='b2Mat22 +')
        self.checkAlmostEqual(m.col2, (y+y, x+x), msg='b2Mat22 +')
        m = m2 - m2
        self.checkAlmostEqual(m.col1, (0,0), msg='b2Mat22 -')
        self.checkAlmostEqual(m.col2, (0,0), msg='b2Mat22 -')
        # x y  * x
        # y x    y
        v = m2 * v2
        self.checkAlmostEqual(v, (x*x + y*y, y*x + y*x), msg='b2Mat22 * b2Vec2')
        i=m2.inverse
        i=m2.angle
        m = m2 * m2
        self.checkAlmostEqual(m.col1, (x*x + y*y, y*x + y*x), msg='b2Mat22 * b2Mat22')
        self.checkAlmostEqual(m.col2, (x*y + y*x, y*y + x*x), msg='b2Mat22 * b2Mat22')

        m2 += m2
        self.checkAlmostEqual(m2.col1, (x+x, y+y), msg='b2Mat22 +=')
        self.checkAlmostEqual(m2.col2, (y+y, x+x), msg='b2Mat22 +=')
        m2 -= m2
        self.checkAlmostEqual(m2.col1, (0,0), msg='b2Mat22 -=')
        self.checkAlmostEqual(m2.col2, (0,0), msg='b2Mat22 -=')

    def test_mat33_identity(self):
        i3 = b2Mat33()
        self.checkAlmostEqual(i3.col1, (1.0, 0.0, 0.0), msg='mat33 col1')
        self.checkAlmostEqual(i3.col2, (0.0, 1.0, 0.0), msg='mat33 col2')
        self.checkAlmostEqual(i3.col3, (0.0, 0.0, 1.0), msg='mat33 col3')

    def test_mat33(self):
        x, y, z = 1.0, 2.0, 3.0
        v3 = b2Vec3(x, y, z)
        m3 = b2Mat33((x, y, z), (z, y, x), (y, x, z))
        m = m3 + m3
        self.checkAlmostEqual(m.col1, (x+x, y+y, z+z), msg='b2Mat33 +')
        self.checkAlmostEqual(m.col2, (z+z, y+y, x+x), msg='b2Mat33 +')
        self.checkAlmostEqual(m.col3, (y+y, x+x, z+z), msg='b2Mat33 +')
        m = m3 - m3
        self.checkAlmostEqual(m.col1, (0,0,0), msg='b2Mat33 -')
        self.checkAlmostEqual(m.col2, (0,0,0), msg='b2Mat33 -')
        self.checkAlmostEqual(m.col3, (0,0,0), msg='b2Mat33 -')
        m3 += m3
        self.checkAlmostEqual(m3.col1, (x+x, y+y, z+z), msg='b2Mat33 +=')
        self.checkAlmostEqual(m3.col2, (z+z, y+y, x+x), msg='b2Mat33 +=')
        self.checkAlmostEqual(m3.col3, (y+y, x+x, z+z), msg='b2Mat33 +=')
        m3 -= m3
        self.checkAlmostEqual(m3.col1, (0,0,0), msg='b2Mat33 -=')
        self.checkAlmostEqual(m3.col2, (0,0,0), msg='b2Mat33 -=')
        self.checkAlmostEqual(m3.col3, (0,0,0), msg='b2Mat33 -=')


if __name__ == '__main__':
    unittest.main()


