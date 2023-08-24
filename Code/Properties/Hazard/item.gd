extends Node 

enum item_type { HEAL, AMMO, SHOOT }
export(PackedScene) var death_effect

export(float) var life_time
onready var item_timer = $ItemTimer

export(item_type) var type

onready var item_position = $ItemPosition

signal used(position) 

func _ready():
	item_timer.start(life_time)

func _process(delta):
	if item_timer.is_stopped():
		emit_signal("used", item_position)
		queue_free()

func destroy():
	emit_signal("used", item_position)

	var effect = death_effect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = item_position.global_position
	queue_free()
