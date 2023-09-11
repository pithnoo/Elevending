extends Node

export(Array, int) var level_ratings setget calculate_total_ratings
var total_ratings : int

var levels_unlocked : int = 1

# for level_data to scene transition to next level
signal next_level

func calculate_total_ratings(value):
	for i in level_ratings.size():
		total_ratings += i

func save_game():
	pass

func _ready():
	# load game save resource, storing current levels and the player upgrades
	pass
