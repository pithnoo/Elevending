extends Node


func _on_Empty_turret_empty():
	AudioManager.play("TurretUsed")
	get_parent().queue_free()
