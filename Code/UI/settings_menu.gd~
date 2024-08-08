extends Control

func _on_ExitButton_pressed():
	AudioManager.play("ButtonPress")

	# write new audio data here
	LevelManager.master_vol = db2linear(AudioServer.get_bus_volume_db(0))
	LevelManager.music_vol = db2linear(AudioServer.get_bus_volume_db(1))
	LevelManager.sfx_vol = db2linear(AudioServer.get_bus_volume_db(2))
	LevelManager.save_audio_progress()

	visible = false
