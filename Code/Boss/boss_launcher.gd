extends Node

onready var particle_generator = $ParticleGenerator
onready var particle_position = $ParticlePosition

export(PackedScene) var death_effect 
export(PackedScene) var death_particle

export(bool) var is_hard

export(NodePath) var count_animations
onready var count_anim = get_node(count_animations)

export(NodePath) var machine_node
onready var machine_container = get_node(machine_node)

export(NodePath) var count_sprite_node
onready var count_sprite = get_node(count_sprite_node)

func _ready():
	count_anim.play("EasyCounter")
	
	# INFO: to make sure that the counter remains in the correct orientation
	count_sprite.flip_h = machine_container.get_scale().x < 0


func _on_Stats_no_health():
	AudioManager.play("EnemyDestroyed")
	particle_generator.generate_particle(death_particle, particle_position)
	queue_free()
