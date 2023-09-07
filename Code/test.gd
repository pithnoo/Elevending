extends Node2D

export(String, FILE, "*.tscn,*.scn") var game

func _ready():
	get_tree().paused = false

func _on_PlayButton_pressed():
	SceneTransition.blind_transition(game)
