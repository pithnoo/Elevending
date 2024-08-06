extends Control

func _on_ExitButton_pressed():
	AudioManager.play("ButtonPress")
	visible = false
