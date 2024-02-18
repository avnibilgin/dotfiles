from enum import Enum

class Direction(Enum):
	swipe_down = 0
	swipe_down_right = 45
	swipe_right = 90
	swipe_up_right = 135
	swipe_up = 180
	swipe_up_left = 225
	swipe_left = 270
	swipe_down_left = 315

	def __str__(self):
		return self.name

	def __repr__(self):
		return self.__str__()