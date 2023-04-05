class_name Hazard
extends Area2D 

export(PackedScene) var deathEffect
export(int) var damage

func destroy():
	var effect = deathEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
	get_parent().queue_free()
