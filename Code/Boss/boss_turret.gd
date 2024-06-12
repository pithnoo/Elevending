extends Node

onready var turret_timer = $Timer
onready var anim = $AnimationPlayer
onready var particle_generator = $ParticleGenerator
onready var particle_position = $ParticlePosition

export(PackedScene) var death_effect
export(PackedScene) var death_particle
export(PackedScene) var boss_projectile

export(int) var turret_time

func _ready():
	turret_timer.start(turret_time)
	AudioManager.play("TurretPlace")

func _process(delta):
	if turret_timer.is_stopped():
		anim.play("Attack")

func turret_attack():
	# TODO: add enemy attack sound effect
	# TODO: spawn and direct projectile towards core
	particle_generator.generate_particle(death_effect, particle_position)
	particle_generator.generate_particle(boss_projectile, particle_position)
	queue_free()


func _on_Stats_no_health():
	AudioManager.play("EnemyDestroyed")
	particle_generator.generate_particle(death_particle, particle_position)
	queue_free()
