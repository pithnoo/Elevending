extends Control

export(String, FILE, "*.tscn,*.scn") var menu

export(NodePath) var settings_menu_node
onready var settings_menu = get_node(settings_menu_node)

var cursor_buffer: int

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
	AudioManager.stop_playing(AudioManager.current_theme)
	SceneTransition.blind_transition(menu)

	# to show the level_select screen straight away
	GameManager.level_select_first = true

func _on_SettingsButton_pressed():
	AudioManager.play("ButtonPress")
	settings_menu.visible = true

func _on_ResumeButton_pressed():
	var current_pause_state = not get_tree().paused
	get_tree().paused = current_pause_state
	visible = current_pause_state

	AudioManager.play("ButtonPress")
	GameManager.change_game_cursor(cursor_buffer)
