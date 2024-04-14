extends Control

func _ready():
  visible = true
  GameManager.has_tutorial = true
  get_tree().paused = true
  GameManager.can_pause = false

func _on_TutorialButton_pressed():
  visible = false
  GameManager.has_tutorial = false
  get_tree().paused = false
  GameManager.can_pause = true
  AudioManager.play("ButtonPress")
