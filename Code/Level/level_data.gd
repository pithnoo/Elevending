extends Node2D

export(String, FILE, "*.tscn,*.scn") var next_level

export(int) var level_number
onready var level_index = level_number - 1

export(int) var coin_requirement1
export(int) var coin_requirement2
export(int) var coin_requirement3

var previous_level_rating : int
var level_rating : int

# bool to check if the level already has a rating
var has_rating : bool

onready var level_camera = $LevelCamera

func _ready():
	LevelManager.connect("next_level", self, "goto_next_level")
	# if the level already has a rating, then the size of the array
	# should be equal to the array index
	if LevelManager.level_ratings.size() > level_index:
		previous_level_rating = LevelManager.level_ratings[level_index]
		has_rating = true
	else:
		has_rating = false

	GameManager.connect("level_complete", self, "rate_level")

	# sets camera to level for screen shake, game over screen switches camera
	level_camera.current = true

	# during transitions, the player will be unable to pause
	GameManager.can_pause = true

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

	# if the levels rating is higher than what is currently saved
	# write new value rating
	if has_rating && level_rating > previous_level_rating:
		LevelManager.level_ratings[level_index] = level_rating
		print("rewritten")
	elif !has_rating:
		LevelManager.level_ratings.append(level_rating)

	if level_index > LevelManager.levels_unlocked:
		LevelManager.levels_unlocked = level_index
		#print(LevelManager.levels_unlocked)

	#print(LevelManager.level_ratings)

	GameManager.emit_signal("display_rating", level_rating)

func goto_next_level():
	# transition to next level
	GameManager.reset_game_values()
	SceneTransition.blind_transition(next_level)
