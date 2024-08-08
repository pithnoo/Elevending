extends Node2D

export(String, FILE, "*.tscn,*.scn") var next_level

export(int) var level_number
onready var level_index = level_number - 1

export(int) var coin_requirement1
export(int) var coin_requirement2
export(int) var coin_requirement3

export(int) var level_ground_turrets
export(int) var level_electric_turrets
export(int) var core_health

var previous_level_rating: int
var level_rating: int

# bool to check if the level already has a rating
var has_rating: bool

onready var level_camera = $LevelCamera

func start_level_theme():
	# make sure to set the current theme too
	if level_number == 9:
		# boss theme
		AudioManager.play("Udon")
		AudioManager.current_theme = "Udon"
	elif level_number == 8 && level_number == 7:
		# hard theme
		pass
	elif level_number <= 6 && level_number >= 4:
		# medium theme
		pass
	else:
		# easy theme
		pass

func _ready():
	start_level_theme()
	
	# debugging health changes from ui in game
	#print("level: ", level_number, " health: ", core_health)

	CoreStats.max_health = core_health
	CoreStats.health = core_health

	CoreStats.emit_signal("max_health_changed", core_health)
	CoreStats.emit_signal("health_changed", core_health)

	GameManager.ground_turret_number = level_ground_turrets
	GameManager.electric_turret_number = level_electric_turrets

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

func rate_level():
	if GameManager.game_currency < coin_requirement1:
		level_rating = 0
	elif (
		GameManager.game_currency >= coin_requirement1
		&& GameManager.game_currency < coin_requirement2
	):
		level_rating = 1
	elif (
		GameManager.game_currency >= coin_requirement2
		&& GameManager.game_currency < coin_requirement3
	):
		level_rating = 2
	else:
		# in any other case, the score exceeds all coin requirements
		level_rating = 3

	write_level_data()

	if level_index == LevelManager.levels_unlocked - 1:
		LevelManager.levels_unlocked = level_number + 1
		LevelManager.save_level_progress()
		#print(LevelManager.levels_unlocked)

	#print(LevelManager.level_ratings)

	GameManager.emit_signal("display_rating", level_rating)


func goto_next_level():
	# transition to next level
	GameManager.reset_game_values()
	SceneTransition.blind_transition(next_level)

func _on_Dead_rate_boss_level():
	var core_quarter = round(CoreStats.max_health / 4)
	var core_half = round(CoreStats.max_health / 2)

	if CoreStats.health == CoreStats.max_health:
		level_rating = 3
	elif CoreStats.health < CoreStats.max_health && CoreStats.health >= core_half:
		level_rating = 2
	elif CoreStats.health < core_half && CoreStats.health >= core_quarter:
		level_rating = 1
	else:
		level_rating = 0

	write_level_data()

func write_level_data():
	# if the levels rating is higher than what is currently saved
	# write new value rating
	if has_rating && level_rating > previous_level_rating:
		LevelManager.level_ratings[level_index] = level_rating
		LevelManager.save_level_progress()
		print("rewritten")
	elif !has_rating:
		LevelManager.level_ratings.append(level_rating)
