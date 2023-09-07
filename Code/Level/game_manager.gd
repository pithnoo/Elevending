extends Node

# turrets
signal ammo_reload
signal fire_rate_doubled
var is_manual : bool = false

export(int) var max_ground_turrets
export(int) var max_electric_turrets
onready var ground_turret_number setget set_ground
onready var electric_turret_number setget set_electric

signal ground_changed(value)
signal electric_changed(value)

var game_currency : int = 0 setget set_currency
signal currency_changed(value)

# for enemy spawn manager
var current_wave : int = 0
signal show_wave(value)
signal start_wave

# game
signal game_over
signal next_level

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
	self.ground_turret_number = max_ground_turrets
	self.electric_turret_number = max_electric_turrets

func _ready():
	print("active")
	reset_game_values()
