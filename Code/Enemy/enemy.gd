class_name Enemy
extends KinematicBody2D 

# properties of enemy to be used in game
onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var sprite = $Sprite
onready var hurtBox = $HurtBox
onready var hitBox = $CoreHitBox
onready var particleGenerator = $ParticleGenerator
onready var particlePosition = $ParticlePosition

export(PackedScene) var death_particle

export(int) var maxHealth
export(int) var enemyDamage

export(float) var follow_speed 
export(float) var follow_acceleration 

export(float) var resistance
var knockback = Vector2.ZERO

export(Color) var buff_colour
export(NodePath) var buff_particle

signal enemy_dead

var is_stunned : bool = false

# variables to be changed by the enemy manager
var health: int
var velocity = Vector2.ZERO

func _ready():
	states.init(self)
	hitBox.damage = enemyDamage

func _process(delta):
  states.process(delta)

func _physics_process(delta: float) -> void:
  knockback = knockback.move_toward(Vector2.ZERO, resistance * delta)
  knockback = move_and_slide(knockback)

  states.physics_process(delta)

func _on_Stats_no_health():
	AudioManager.play("EnemyDestroyed")

	# instantiate death effect
	particleGenerator.generate_particle(death_particle, particlePosition)

	# signal of enemy's death for wave manager
	emit_signal("enemy_dead")

	GameManager.game_currency += 1

	queue_free()

func _on_HurtBox_enemy_buffed():
	# note that this is only executed once because of enemy hurt box script
	enemyDamage *= 2
	hitBox.damage = enemyDamage
	follow_speed /= 2

	sprite.modulate = buff_colour
	
	get_node(buff_particle).visible = true

func _on_HurtBox_enemy_stunned():
	is_stunned = true

func _on_CoreHitBox_collided():
	AudioManager.play("EnemyDestroyed")
	emit_signal("enemy_dead")
