extends Node

export(NodePath) var hit_flash
export(NodePath) var particle_generator
export(PackedScene) var item_destroyed
export(int) var projectile_life_time

onready var particle_position = $EffectPosition
onready var life_timer = $LifeTimer

signal item_destroyed
signal item_heal
signal item_ammo
signal item_shoot


func _ready():
	life_timer.start(projectile_life_time)


func _process(delta):
	if life_timer.is_stopped():
		collection_complete()


func _on_HitBox_area_entered(area: Area2D):
	get_node(hit_flash).play("Start")

	match area.type:
		area.item_type.HEAL:
			emit_signal("item_heal")
		area.item_type.AMMO:
			emit_signal("item_ammo")
		area.item_type.SHOOT:
			emit_signal("item_shoot")
		_:
			AudioManager.play("Reload")

	area.destroy()

	# get_node(particle_generator).generate_particle(item_destroyed, particle_position)

	collection_complete()


func collection_complete():
	emit_signal("item_destroyed")
	queue_free()
