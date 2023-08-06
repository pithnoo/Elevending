class_name Enemy
extends KinematicBody2D 

# properties of enemy to be used in game
onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var sprite = $Sprite
onready var hurtBox = $HurtBox
onready var hitBox = $CoreHitBox

export(int) var maxHealth

export(float) var follow_speed 
export(float) var follow_acceleration 

export(Color) var buff_colour
export(NodePath) var buff_particle

signal enemy_dead

# variables to be changed by the enemy manager
var health: int
var velocity = Vector2.ZERO

func _ready():
  states.init(self)

func _process(delta):
  states.process(delta)

func _physics_process(delta: float) -> void:
  states.physics_process(delta)

func _on_Stats_no_health():
  # instantiate death effect
  emit_signal("enemy_dead")

  queue_free()

func _on_HurtBox_enemy_buffed():
	hitBox.damage *= 2
	follow_speed /= 2

	sprite.modulate = buff_colour
	
	get_node(buff_particle).visible = true
