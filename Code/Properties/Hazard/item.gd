extends Node 

enum item_type { HEAL, AMMO, SHOOT }
export(PackedScene) var death_effect

export(item_type) var type

onready var item_position = $ItemPosition

func destroy():
	var effect = death_effect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = item_position.global_position
	queue_free()
