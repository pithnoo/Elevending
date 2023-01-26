extends Area2D

enum element { GRASS, WATER, FIRE }

export(PackedScene) var deathEffect
export(element) var type
export(int) var damage

func destroy():
  var effect = deathEffect.instance()
  var main = get_tree().current_scene
  main.add_child(effect)
  effect.global_position = global_position
  queue_free()
