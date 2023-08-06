extends Node

func _on_Empty_turret_empty():
	get_parent().queue_free()
