class Gesture:
	swipes = []
	commands = []

	def __init__(self, swipes, commands):
		self.swipes = swipes
		self.commands = commands

	def __str__(self):
		return f'Gesture(swipes={self.swipes},keys={self.commands})'

	def __repr__(self):
		return self.__str__()