class_name HurtBox
extends Area2D 

export(NodePath) var entity_stats

onready var stats = get_node(entity_stats)

func _on_HurtBox_area_entered(area:Area2D):
	stats.health -= area.damage
	area.destroy()
