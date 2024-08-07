extends Node

export(int) var max_health = 1 setget set_max_health
onready var health = max_health setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	emit_signal("max_health_changed", max_health)

func set_health(value):
	# to ensure that health doesn't exceed its max, or becomes negative
	# useful for UI
	health = clamp(value, 0, max_health)

	emit_signal("health_changed", health)

	if health <= 0:
		emit_signal("no_health")

func _ready():
  self.max_health = max_health
  self.health = max_health
