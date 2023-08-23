class_name ItemBaseState
extends Node

export(String) var animation_name

var item : Item

func enter() -> void:
	item.animations.play(animation_name)

func exit() -> void:
  pass

func input(_event: InputEvent) -> ItemBaseState:
  return null

func process(_delta: float) -> ItemBaseState:
  return null

func physics_process(_delta: float) -> ItemBaseState:
  return null
