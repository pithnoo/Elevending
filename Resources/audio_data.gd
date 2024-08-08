class_name AudioFile
extends Resource

const SAVE_AUDIO_PATH := "user://audio.json"
var _audio_file := File.new()

var master_vol : float
var music_vol : float
var sfx_vol : float

func audio_exists() -> bool:
	return _audio_file.file_exists(SAVE_AUDIO_PATH)

func write_audio() -> void:
	var error := _audio_file.open(SAVE_AUDIO_PATH, File.WRITE)
	if error != OK:
		printerr("couldn't open file %s. Error code %s" % [SAVE_AUDIO_PATH, error])
		return

	var data := {
		"master_vol": master_vol,
		"music_vol": music_vol,
		"sfx_vol": sfx_vol,
		}

	var json_string := JSON.print(data)
	_audio_file.store_string(json_string)
	_audio_file.close()

func load_audio() -> void:
	var error := _audio_file.open(SAVE_AUDIO_PATH, File.READ)
	if error != OK:
		printerr("couldn't open file %s. Error code %s" % [SAVE_AUDIO_PATH, error])
		return

	var content := _audio_file.get_as_text()
	_audio_file.close()

	var data : Dictionary = JSON.parse(content).result

	AudioServer.set_bus_volume_db(0, linear2db(data.master_vol))
	AudioServer.set_bus_volume_db(1, linear2db(data.music_vol))
	AudioServer.set_bus_volume_db(2, linear2db(data.sfx_vol))
