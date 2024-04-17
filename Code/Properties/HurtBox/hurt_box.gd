class_name HurtBox
extends Area2D 

export(NodePath) var entity_stats
export(NodePath) var hit_flash

# INFO: exclusively for the boss
var invincible = false

onready var stats = get_node(entity_stats)

func _on_HurtBox_area_entered(area:Area2D):

	get_node(hit_flash).play("Start")

	if !invincible:
		stats.health -= area.damage

	if area.type != area.element.GROUND:
		area.destroy()
