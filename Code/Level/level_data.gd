extends Node2D

export(int) var coin_requirement1
export(int) var coin_requirement2
export(int) var coin_requirement3

var level_rating : int

onready var level_camera = $LevelCamera

func _ready():
	GameManager.connect("level_complete", self, "rate_level")

	level_camera.current = true

func rate_level():
	if GameManager.game_currency < coin_requirement1:
		level_rating = 0
	elif GameManager.game_currency >= coin_requirement1 && GameManager.game_currency < coin_requirement2:
		level_rating = 1
	elif GameManager.game_currency >= coin_requirement2 && GameManager.game_currency < coin_requirement3:
		level_rating = 2
	else:
		# in any other case, the score exceeds all coin requirements
		level_rating = 3

	print("level score: ", level_rating)

	GameManager.emit_signal("display_rating", level_rating)
