extends EnemyBaseState 
class_name EnemyFollowState

func enter() -> void:
  enemy.velocity = Vector2.ZERO

func follow_entity(detect, delta) -> void:
  var target = detect.entities[0].global_position
  var direction = enemy.global_position.direction_to(target)
  
  enemy.velocity = enemy.velocity.move_toward(direction * enemy.follow_speed, delta * enemy.follow_acceleration) 
  enemy.velocity = enemy.move_and_slide(enemy.velocity)

  enemy.sprite.flip_h = enemy.velocity.x > 0
