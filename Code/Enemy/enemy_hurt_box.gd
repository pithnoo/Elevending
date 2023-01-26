extends Area2D 

export(NodePath) var entity_stats

onready var stats = get_node(entity_stats)

signal same_type
signal adv_type
signal disadv_type

enum damage_type { GRASS, WATER, FIRE }
export(damage_type) var type

func _on_HurtBox_area_entered(area:Area2D):
  match type:
    damage_type.GRASS:
      # type matchups for grass
      match area.type:
        area.element.GRASS:
          pass
        area.element.WATER:
          pass
        area.element.FIRE:
          pass
    damage_type.WATER:
      # type matchups for water
      match area.type:
        area.element.GRASS:
          pass
        area.element.WATER:
          pass
        area.element.FIRE:
          pass
    damage_type.FIRE:
      # type matchups for grass
      match area.type:
        area.element.GRASS:
          pass
        area.element.WATER:
          pass
        area.element.FIRE:
          pass

  stats.health -= area.damage
  area.destroy()

func damage_enemy():
  emit_signal("adv_type")

func buff_enemy():
  emit_signal("same_type")

func half_damage_enemy():
  emit_signal("disadv_type")
