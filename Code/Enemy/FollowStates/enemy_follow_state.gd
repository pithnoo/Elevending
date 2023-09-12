extends EnemyBaseState 
class_name EnemyFollowState

var enemy_spacing = 120

func enter() -> void:
  enemy.velocity = Vector2.ZERO

func follow_entity(detect, delta, is_flipped) -> void:
	var target = detect.entities[0].global_position
	var direction = enemy.global_position.direction_to(target)

	enemy.velocity = enemy.velocity.move_toward(direction * enemy.follow_speed, delta * enemy.follow_acceleration) 

	if is_flipped:
		enemy.sprite.flip_h = enemy.velocity.x < 0
	else:
		enemy.sprite.flip_h = enemy.velocity.x > 0

	if enemy.softCollision.is_colliding():
		enemy.velocity += enemy.softCollision.get_push_vector() * enemy_spacing * delta

	enemy.velocity = enemy.move_and_slide(enemy.velocity)
