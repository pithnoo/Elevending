extends HurtBox 

signal enemy_buffed 

enum damage_type { GRASS, WATER, FIRE }
export(damage_type) var type
export(PackedScene) var buff_particle

var buffed : bool = false

func _on_HurtBox_area_entered(area:Area2D):
	match type:
		damage_type.GRASS:
			# type matchups for grass
			match area.type:
				area.element.GRASS:
					buff_enemy()
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
					buff_enemy()
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
					buff_enemy()
					
	area.destroy()

func buff_enemy() -> void:
	if !buffed:
		emit_signal("enemy_buffed")
		buffed = true
