extends Node

export(Array, int) var level_ratings
var total_ratings: int

var levels_unlocked: int = 1

# for level_data to scene transition to next level
signal next_level

# an instance of the saved game data
var _save = SaveFile.new()


func load_level_progress():
	if _save.save_exists():
		_save.load_game()
	else:
		_save.levels_unlocked = levels_unlocked
		_save.level_ratings = level_ratings
		_save.write_game()

	levels_unlocked = _save.levels_unlocked
	level_ratings = _save.level_ratings


func save_level_progress():
	_save.levels_unlocked = levels_unlocked
	_save.level_ratings = level_ratings
	_save.write_game()


func _ready():
	# load game save resource, storing current levels and the player upgrades
	load_level_progress()
