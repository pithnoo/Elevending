extends HurtBox

enum damage_type { GRASS, WATER, FIRE }
export(damage_type) var type

func _on_HurtBox_area_entered(area:Area2D):
	match type:
		damage_type.GRASS:
			match area.type:
				area.element.FIRE:
					get_node(hit_flash).play("Start")
					stats.health -= area.damage
				_:
					pass
		damage_type.WATER:
			match area.type:
				area.element.GRASS:
					get_node(hit_flash).play("Start")
					stats.health -= area.damage
				_:
					pass
		damage_type.FIRE:
			match area.type:
				area.element.WATER:
					get_node(hit_flash).play("Start")
					stats.health -= area.damage
				_:
					pass

	area.destroy()
