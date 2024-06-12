class_name TurretBaseState
extends Node

export(String) var animation_name

# instance of entity turret
var turret: Turret


# plays animation for that instance of turret
func enter() -> void:
	turret.animations.play(animation_name)


func exit() -> void:
	pass


func input(_event: InputEvent) -> TurretBaseState:
	return null


func process(_delta: float) -> TurretBaseState:
	return null


func physics_process(_delta: float) -> TurretBaseState:
	return null
