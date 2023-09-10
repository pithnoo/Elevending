extends Node2D

export(String, FILE, "*.tscn,*.scn") var game

func _ready():
	print("menu")

func _on_PlayButton_pressed():
	SceneTransition.blind_transition(game)
	GameManager.reset_game_values()
