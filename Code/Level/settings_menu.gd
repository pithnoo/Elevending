extends Control

func _ready():
	GameManager.connect("show_sound_settings", self, "show_settings")

func show_settings():
	GameManager.can_pause = false
	visible = true

func _on_ExitButton_pressed():
	GameManager.can_pause = true
	AudioManager.play("ButtonPress")
	visible = false
