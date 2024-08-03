extends Node

export(NodePath) var boss_avatar_node
export(NodePath) var boss_machine_node

onready var boss_avatar = get_node(boss_avatar_node)
onready var boss_machine = get_node(boss_machine_node)

func _ready():
  var avatar_tween := create_tween()
  var machine_tween := create_tween()

  avatar_tween.tween_property(boss_avatar, "self_modulate", Color(1,1,1,0), 0.15).set_delay(0.01)
  machine_tween.tween_property(boss_machine, "self_modulate", Color(1,1,1,0), 0.15)

  yield(avatar_tween, "finished")
  yield(machine_tween, "finished")

  queue_free()
