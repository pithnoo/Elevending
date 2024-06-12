class_name EnemyBaseState
extends Node

export(String) var animation_name

var enemy: Enemy


func enter() -> void:
	enemy.animations.play(animation_name)


func exit() -> void:
	pass


func input(_event: InputEvent) -> EnemyBaseState:
	return null


func process(_delta: float) -> EnemyBaseState:
	return null


func physics_process(_delta: float) -> EnemyBaseState:
	return null
