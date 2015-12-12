#!/usr/bin/env python

import unittest
from Box2D import (b2Vec2, b2Vec3)


class testVector (unittest.TestCase):
    def test_vec2_zero(self):
        v2 = b2Vec2()
        self.assertAlmostEqual(v2.x, 0.0)
        self.assertAlmostEqual(v2.y, 0.0)

    def test_vec2(self):
        x, y = 1.0, 2.0
        v = b2Vec2(x, y)
        v += (0.1, 0.1)
        self.assertAlmostEqual(v.x, x + 0.1, places=2)
        self.assertAlmostEqual(v.y, y + 0.1, places=2)

        v -= (0.1, 0.1)
        self.assertAlmostEqual(v.x, x, places=2)
        self.assertAlmostEqual(v.y, y, places=2)

        v = b2Vec2(x, y)
        v /= 2.0
        self.assertAlmostEqual(v.x, x / 2.0)
        self.assertAlmostEqual(v.y, y / 2.0)
        v *= 2.0
        self.assertAlmostEqual(v.x, x)
        self.assertAlmostEqual(v.y, y)

        v2 = b2Vec2(x, y)
        v = v2 + v2
        self.assertAlmostEqual(v.x, x * 2)
        self.assertAlmostEqual(v.y, y * 2)
        v = v2 - v2
        self.assertAlmostEqual(v.x, 0)
        self.assertAlmostEqual(v.y, 0)
        v = v2 / 2.0
        self.assertAlmostEqual(v.x, x / 2)
        self.assertAlmostEqual(v.y, y / 2)
        v = v2 * 2.0
        self.assertAlmostEqual(v.x, x * 2)
        self.assertAlmostEqual(v.y, y * 2)
        v = 0.5 * v2
        self.assertAlmostEqual(v.x, x * 0.5)
        self.assertAlmostEqual(v.y, y * 0.5)
        v = 2.0 * v2
        self.assertAlmostEqual(v.x, x * 2)
        self.assertAlmostEqual(v.y, y * 2)

    def test_vec3_zero(self):
        v3 = b2Vec3()
        self.assertAlmostEqual(v3.x, 0.0)
        self.assertAlmostEqual(v3.y, 0.0)
        self.assertAlmostEqual(v3.z, 0.0)

    def test_vec3(self):
        x, y, z = 1.0, 2.0, 3.0
        v3 = b2Vec3(x, y, z)

        v = v3 + v3
        self.assertAlmostEqual(v.x, x * 2)
        self.assertAlmostEqual(v.y, y * 2)
        self.assertAlmostEqual(v.z, z * 2)
        v = v3 - v3
        self.assertAlmostEqual(v.x, 0)
        self.assertAlmostEqual(v.y, 0)
        self.assertAlmostEqual(v.z, 0)
        v = v3 / 2.0
        self.assertAlmostEqual(v.x, x / 2)
        self.assertAlmostEqual(v.y, y / 2)
        self.assertAlmostEqual(v.z, z / 2)
        v = v3 * 2.0
        self.assertAlmostEqual(v.x, x * 2)
        self.assertAlmostEqual(v.y, y * 2)
        self.assertAlmostEqual(v.z, z * 2)
        v = 0.5 * v3
        self.assertAlmostEqual(v.x, x * 0.5)
        self.assertAlmostEqual(v.y, y * 0.5)
        self.assertAlmostEqual(v.z, z * 0.5)
        v = 2.0 * v3
        self.assertAlmostEqual(v.x, x * 2)
        self.assertAlmostEqual(v.y, y * 2)
        self.assertAlmostEqual(v.z, z * 2)

        v = b2Vec3(x, y, z)
        v += (0.1, 0.1, 0.1)
        self.assertAlmostEqual(v.x, x + 0.1, places=2)
        self.assertAlmostEqual(v.y, y + 0.1, places=2)
        self.assertAlmostEqual(v.z, z + 0.1, places=2)
        v -= (0.1, 0.1, 0.1)
        self.assertAlmostEqual(v.x, x, places=2)
        self.assertAlmostEqual(v.y, y, places=2)
        self.assertAlmostEqual(v.z, z, places=2)
        v /= 1
        self.assertAlmostEqual(v.x, x, places=2)
        self.assertAlmostEqual(v.y, y, places=2)
        self.assertAlmostEqual(v.z, z, places=2)
        v *= 1
        self.assertAlmostEqual(v.x, x, places=2)
        self.assertAlmostEqual(v.y, y, places=2)
        self.assertAlmostEqual(v.z, z, places=2)


if __name__ == '__main__':
    unittest.main()
