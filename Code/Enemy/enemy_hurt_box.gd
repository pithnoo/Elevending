extends Area2D 

export(NodePath) var entity_stats

onready var stats = get_node(entity_stats)

signal buff_enemy 

enum damage_type { GRASS, WATER, FIRE }
export(damage_type) var type

func _on_HurtBox_area_entered(area:Area2D):
	match type:
		damage_type.GRASS:
			# type matchups for grass
			match area.type:
				area.element.GRASS:
					emit_signal("buff_enemy")
				area.element.WATER:
					stats.health -= area.damage / 2
				area.element.FIRE:
					stats.health -= area.damage
		damage_type.WATER:
			# type matchups for water
			match area.type:
				area.element.GRASS:
					stats.health -= area.damage
				area.element.WATER:
					emit_signal("buff_enemy")
				area.element.FIRE:
					stats.health -= area.damage / 2
		damage_type.FIRE:
			# type matchups for fire 
			match area.type:
				area.element.GRASS:
					stats.health -= area.damage / 2
				area.element.WATER:
					stats.health -= area.damage
				area.element.FIRE:
					emit_signal("buff_enemy")
					
	#print(area)
	area.destroy()
