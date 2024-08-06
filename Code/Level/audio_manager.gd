extends Node

var current_theme : String
var sounds: Array
var sound_names: Array

func play(effect_name: String) -> void:
	var sound_index = sound_names.find(effect_name, 0)

	if sound_index == -1:
		print(effect_name, " not found")
		return

	sounds[sound_index].play()

func stop_playing(current_sound: String) -> void:
	var sound_index = sound_names.find(current_sound, 0)

	if sound_index == -1:
		print(current_sound, " is not currently playing")
		return

	sounds[sound_index].stop()

func _ready():
	for effect in get_children():
		if effect is AudioStreamPlayer:
			sounds.append(effect)
			sound_names.append(effect.name)
