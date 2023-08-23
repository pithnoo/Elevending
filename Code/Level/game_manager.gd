extends Node

signal ammo_reload
signal fire_rate_doubled
signal health_restore(value)

var is_manual : bool = false

func _ready():
	pass # Replace with function body.

func reload():
	emit_signal("ammo_reload")

func increase_fire_rate():
	emit_signal("fire_rate_doubled")

#func _process(delta):
#	pass
