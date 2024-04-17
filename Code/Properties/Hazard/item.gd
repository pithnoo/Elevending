extends Node 

enum item_type { HEAL, AMMO, SHOOT, BOSS }
export(PackedScene) var death_effect
export(PackedScene) var boss_projectile

export(float) var life_time
onready var item_timer = $ItemTimer

export(item_type) var type

onready var item_position = $ItemPosition

signal used(position) 

func _ready():
	item_timer.start(life_time)

func _process(delta):
	if item_timer.is_stopped():
		if type == item_type.BOSS:
			var projectile = boss_projectile.instance()
			var main = get_tree().current_scene	
			main.add_child(projectile)
			projectile.global_position = item_position.global_position

		hazard_effect()
		emit_signal("used", item_position)
		queue_free()

func destroy():
	emit_signal("used", item_position)
	hazard_effect()
	queue_free()

func hazard_effect():
	var effect = death_effect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = item_position.global_position
