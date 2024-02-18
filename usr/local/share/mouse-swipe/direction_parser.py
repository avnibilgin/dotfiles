from direction import Direction

# Parses a string like "swipe_left, swipe_right" and returns a
# list of corresponding directions.
# Throws if the input couldn't be parsed properly.
def parse_directions(input):
	arr = list(map(str.strip, input.split(',')))
	directions = list(map(Direction.__getitem__, arr))
	if _contains_consecutives(directions):
		raise ValueError("The directions list '{}' contained consecutive directions. This can't be detected.".format(input))
	return directions

def _contains_consecutives(array):
 	return any(i==j for i,j in zip(array, array[1:]))