class_name BossBaseState
extends Node

export(String) var animation_name

var boss: Boss 

func enter() -> void:
	boss.animations.play(animation_name)

func exit() -> void:
  pass

func input(_event: InputEvent) -> EnemyBaseState:
  return null

func process(_delta: float) -> EnemyBaseState:
  return null

func physics_process(_delta: float) -> EnemyBaseState:
  return null
