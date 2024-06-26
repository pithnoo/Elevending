extends Control

export(String, FILE, "*.tscn,*.scn") var menu

var cursor_buffer: int


func _input(event):
	if event.is_action_pressed("pause") && GameManager.can_pause:
		cursor_buffer = GameManager.current_cursor

		GameManager.change_game_cursor(0)

		var current_pause_state = not get_tree().paused

		get_tree().paused = current_pause_state

		visible = current_pause_state


func _on_MenuButton_pressed():
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
