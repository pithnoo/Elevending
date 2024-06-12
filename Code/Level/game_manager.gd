extends Node

# to ensure player can't pause during transitions
var can_pause: bool = true
# this ensures that when a tutorial is in level, blind transition won't unpause
var has_tutorial: bool = false
var game_over: bool = false

# a global position that should be known by boss projectiles to save performance
var core_position

# cursors
export(String, FILE, "*png") var neutral_cursor
export(String, FILE, "*png") var manual_cursor
export(String, FILE, "*png") var item_cursor
export(String, FILE, "*png") var turret_cursor

var current_cursor: int

# turrets
signal ammo_reload
signal fire_rate_doubled
var is_manual: bool = false

# in game values to be set in ui
var max_ground_turrets
var max_electric_turrets

onready var ground_turret_number setget set_ground
onready var electric_turret_number setget set_electric

signal ground_changed(value)
signal electric_changed(value)

var game_currency: int = 0 setget set_currency
signal currency_changed(value)

# for enemy spawn manager to display wave
var current_wave: int = 0
signal show_wave(value)
signal start_wave

# for level transition, so that game over transition can play
signal game_over

# for enemy spawn manager, to show all waves spawned
signal level_complete

# for complete UI
signal display_rating(value)

# for sound menu
signal show_sound_settings


func change_game_cursor(cursor_type):
	current_cursor = cursor_type

	# 40 40 offset to center the designed cursor based on the mouse position
	match cursor_type:
		0:
			Input.set_custom_mouse_cursor(load(neutral_cursor), Input.CURSOR_ARROW, Vector2(40, 40))
		1:
			Input.set_custom_mouse_cursor(load(manual_cursor), Input.CURSOR_ARROW, Vector2(40, 40))
		2:
			Input.set_custom_mouse_cursor(load(item_cursor), Input.CURSOR_ARROW, Vector2(40, 40))
		3:
			Input.set_custom_mouse_cursor(load(turret_cursor), Input.CURSOR_ARROW, Vector2(40, 40))
		_:
			print("invalid cursor type")


# for game UI
func display_wave():
	emit_signal("show_wave", current_wave + 1)


func set_currency(value):
	game_currency = value

	emit_signal("currency_changed", value)


func set_ground(value):
	ground_turret_number = value

	emit_signal("ground_changed", value)


func set_electric(value):
	electric_turret_number = value

	emit_signal("electric_changed", value)


# returning to the games menu, values should be reset should the player
# try again
func reset_game_values():
	current_wave = 0
	self.game_currency = 0


func _ready():
	reset_game_values()
