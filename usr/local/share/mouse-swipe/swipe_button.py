from gesture import Gesture
from direction import Direction

class SwipeButton:
    click = []
    freeze, scroll = False, False
    
    pressed = 0
    deltaX, deltaY = 0, 0

    def find_for_swipes(self, swipes):
        for gesture in self.gestures:
            if gesture.swipes == swipes:
                return gesture

    def __init__(self, button, gestures):
        self.button = button
        self.gestures = gestures

        swipe_down = self.find_for_swipes([Direction.swipe_down])
        swipe_right = self.find_for_swipes([Direction.swipe_right])
        swipe_up = self.find_for_swipes([Direction.swipe_up])
        swipe_left = self.find_for_swipes([Direction.swipe_left])

        self.swipe_down = swipe_down.commands if swipe_down else []
        self.swipe_right = swipe_right.commands if swipe_right else []
        self.swipe_up = swipe_up.commands if swipe_up else []
        self.swipe_left = swipe_left.commands if swipe_left else []
