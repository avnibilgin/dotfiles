import math 

from direction import Direction

class SwipeRecognizer:
    # how far the x/y values have to divert from originX/Y before the
    # current swipe direction is checked.
    granularity = 20
    accuracy = 15

    def __init__(self):
        self._swipes = []
        # 0,0 is in the top left of the coordinate system
        self._originX = 0
        self._originY = 0
        self._x = 0
        self._y = 0

    def update(self, deltaX, deltaY):
        self._x += deltaX
        self._y += deltaY
        if self.shouldCheck():
            dir = self.direction()
            if dir != None:
                #lastElement = None if not self._swipes else self._swipes[-1]
                #if lastElement != dir:
                self._swipes.append(dir)
            self.resetCoordinates()

    def swipes(self):
        swipes = []
        current = None

        for swipe in self._swipes:
            if (swipe != current):
                current = swipe
            else:
                lastElement = None if not swipes else swipes[-1]
                if (lastElement == None or lastElement != current):
                    swipes.append(current)

        return swipes

    def resetCoordinates(self):
        self._originX = 0
        self._originY = 0
        self._x = 0
        self._y = 0

    def shouldCheck(self):
        return self.distance() >= (self.granularity*self.granularity)

    def distance(self):
        raw = abs(self._originX - self._x) + abs(self._originY - self._y)
        return raw * raw

    # Returns the Direction of the angle between x/y and originX/Y. Or None if nothing matches.
    def direction(self):
        deg = self.angle_deg()
        for direction in Direction:
            deviation1 = abs(direction.value - deg)
            deviation2 = abs(direction.value - (deg-360)) # needed because 0° == 360°

            if deviation1 < self.accuracy or deviation2 < self.accuracy:
                return direction

        return None

    # Returns the angle between x/y and originX/Y in radians of (-pi/2, pi)
    def angle_rad(self):
        # pi is up
        # pi/2 is right
        # 0 is down
        # -pi/2 is left
        return math.atan2(self._x, self._y)

    # Returns the angle between x/y and originX/Y in degrees of [0..360)
    # 0° is down, and then increasing counter-clockwise
    def angle_deg(self):
        return ((self.angle_rad() * 57.29578) + 360) % 360
