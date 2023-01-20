extends Area2D

enum element { GRASS, WATER, FIRE }
export(element) var type

signal elementDamage(damage)

func _on_FireProjectile_area_entered(_area:Area2D):
  # exports element damage type to enemy
  emit_signal("elementDamage", element)
