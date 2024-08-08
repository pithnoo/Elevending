extends Node

export(Array, int) var level_ratings
var total_ratings: int

var levels_unlocked: int = 1

onready var master_vol = AudioServer.get_bus_volume_db(0)
onready var music_vol = AudioServer.get_bus_volume_db(1)
onready var sfx_vol = AudioServer.get_bus_volume_db(2)

# for level_data to scene transition to next level
signal next_level

# an instance of the saved game data
var _save = SaveFile.new()

# instance of saved audio data
var _audio_save = AudioFile.new()

func load_audio_progress():
	if _audio_save.audio_exists():
		_audio_save.load_audio()

func save_audio_progress():
	_audio_save.master_vol = master_vol
	_audio_save.music_vol = music_vol
	_audio_save.sfx_vol = sfx_vol
	_audio_save.write_audio()

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
	# loading previously set audio settings
	# this doesn't require a new file to be made if not
	load_audio_progress()

	# load game save resource, storing current levels and the player upgrades
	load_level_progress()
