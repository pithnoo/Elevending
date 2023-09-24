class_name SaveFile
extends Resource 

var levels_unlocked : int = 1
var level_ratings : Array

const SAVE_GAME_PATH := "user://save.json"

# := the variable type is inferred by its content
var _file := File.new()

func save_exists() -> bool:
	return _file.file_exists(SAVE_GAME_PATH)

func write_game() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("couldn't open file %s. Error code %s" %[SAVE_GAME_PATH, error])
		return

	# data to be written in a json file
	var data := {
		"levels_unlocked" : levels_unlocked,
		"level_ratings" : level_ratings
	}

	print("check")
	print(data)

	var json_string := JSON.print(data)
	_file.store_string(json_string)
	_file.close()

func load_game() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("couldn't open file %s. Error code %s" %[SAVE_GAME_PATH, error])
		return

	# read data from previously written json file
	var content := _file.get_as_text()
	_file.close()

	var data : Dictionary = JSON.parse(content).result

	levels_unlocked = data.levels_unlocked
	level_ratings = data.level_ratings
