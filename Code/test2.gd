extends Node

export(Array, String) var wave_codes
var wave_value: String
var waves_to_spawn: Array

var final_store: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	for waves in wave_codes:
		for value in waves:
			if value == " ":
				waves_to_spawn.append(wave_value)
				wave_value = ""
			else:
				wave_value += value

		waves_to_spawn.append(wave_value)
		wave_value = ""

		var wave_buffer = waves_to_spawn.duplicate()
		final_store.append(wave_buffer)
		waves_to_spawn.clear()

	print(final_store)
