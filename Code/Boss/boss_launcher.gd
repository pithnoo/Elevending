extends Node

onready var particle_generator = $ParticleGenerator
onready var particle_position = $ParticlePosition
onready var stats = $Stats

export(PackedScene) var death_effect
export(PackedScene) var death_particle
export(PackedScene) var boss_projectile

export(bool) var is_hard

export(NodePath) var count_animations
onready var count_anim = get_node(count_animations)

export(NodePath) var machine_node
onready var machine_container = get_node(machine_node)

export(NodePath) var count_sprite_node
onready var count_sprite = get_node(count_sprite_node)

signal launcher_destroyed
signal launcher_ready

func flip_machine():
  count_sprite.flip_h = 1

func _ready():
  if is_hard:
    count_anim.play("HardCounter")
  else:
    count_anim.play("EasyCounter")

func shoot():
	# TODO: add enemy attack sound effect
	emit_signal("launcher_ready")
	particle_generator.generate_particle(boss_projectile, particle_position)
	particle_generator.generate_particle(death_effect, particle_position)
	queue_free()

func _on_Stats_no_health():
	emit_signal("launcher_destroyed")
	AudioManager.play("EnemyDestroyed")
	particle_generator.generate_particle(death_particle, particle_position)
	queue_free()
