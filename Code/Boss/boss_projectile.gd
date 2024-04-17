extends KinematicBody2D

export(float) var projectile_speed

export(NodePath) var position_node
onready var projectile_position = get_node(position_node)

var velocity

func _ready():
	velocity = Vector2.ZERO

func _physics_process(delta):
	print("updated")
	var target = GameManager.core_position.global_position
	var direction = projectile_position.global_position.direction_to(target)

	velocity = velocity.move_toward(direction * 1000, delta * projectile_speed)

	move_and_slide(velocity)	

func _on_HitBox_collided():
  AudioManager.play("EnemyDestroyed")
