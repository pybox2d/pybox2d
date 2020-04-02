from Box2D import *

class Segfaulter:
    def __init__(self):
        self.world = b2World(contactListener=b2ContactListener())
        body1 = self.world.CreateDynamicBody(position=(0, 0))
        body1.CreateCircleFixture()
        body2 = self.world.CreateDynamicBody(position=(0, 0))
        body2.CreateCircleFixture()

    def step(self):
        self.world.Step(1 / 30, velocityIterations=1, positionIterations=1)


def test_issue_110():
    segfaulter1 = Segfaulter()
    segfaulter2 = Segfaulter()
    for i in range(10):
        segfaulter1.step()
        segfaulter2.step()
