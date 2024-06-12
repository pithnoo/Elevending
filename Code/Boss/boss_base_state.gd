class_name BossBaseState
extends Node

export(String) var animation_name

var boss: Boss


func enter() -> void:
	boss.animations.play(animation_name)

	# INFO: after teleporting, the boss needs to reappear
	boss.visible = true


func exit() -> void:
	pass


func input(_event: InputEvent) -> BossBaseState:
	return null


func process(_delta: float) -> BossBaseState:
	return null


func physics_process(_delta: float) -> BossBaseState:
	return null
