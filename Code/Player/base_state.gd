class_name BaseState
extends Node

export(String) var animation_name

var player: Player


func enter() -> void:
	player.animations.play(animation_name)


func exit() -> void:
	pass


func input(_event: InputEvent) -> BaseState:
	return null


func process(_delta: float) -> BaseState:
	return null


func physics_process(_delta: float) -> BaseState:
	return null
