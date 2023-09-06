extends Control

export(String, FILE, "*.tscn,*.scn") var menu

func _input(event):
	if event.is_action_pressed("pause"):
		var current_pause_state = not get_tree().paused
		get_tree().paused = current_pause_state
		visible = current_pause_state

func _on_MenuButton_pressed():
	SceneTransition.blind_transition(menu)
	#SceneTransition.upgrade_transition(menu)
	#SceneTransition.return_transition(menu)

func _on_SettingsButton_pressed():
	pass # Replace with function body.

func _on_ResumeButton_pressed():
	var current_pause_state = not get_tree().paused
	get_tree().paused = current_pause_state
	visible = current_pause_state
