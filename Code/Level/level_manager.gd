extends Node

export(Array, int) var level_ratings
var levels_unlocked : int

var weapon_upgrades : int

# for level_data to scene transition to next level
signal next_level

func _ready():
	# load game save resource, storing current levels and the player upgrades
	pass
