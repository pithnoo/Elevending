extends Control

export(String, FILE, "*.tscn,*.scn") var menu

var cursor_buffer: int = 0

func _input(event):
	if event.is_action_pressed("pause") && GameManager.can_pause:
		if GameManager.current_cursor != 0:
			cursor_buffer = GameManager.current_cursor

		var current_pause_state = not get_tree().paused

		if current_pause_state == true:
			GameManager.change_game_cursor(0)
		else:
			GameManager.change_game_cursor(cursor_buffer)

		get_tree().paused = current_pause_state
		visible = current_pause_state

func _on_MenuButton_pressed():
	# current theme is managed by the audio manager
	AudioManager.stop_playing(AudioManager.current_theme)

	SceneTransition.blind_transition(menu)

func _on_SettingsButton_pressed():
	AudioManager.play("ButtonPress")
	GameManager.emit_signal("show_sound_settings")

func _on_ResumeButton_pressed():
	var current_pause_state = not get_tree().paused
	get_tree().paused = current_pause_state
	visible = current_pause_state

	AudioManager.play("ButtonPress")
	GameManager.change_game_cursor(cursor_buffer)
