extends EnemyBaseState 
class_name EnemyFollowState

export(float) var follow_speed 
export(float) var follow_acceleration 
export(NodePath) var player_range
export(NodePath) var core_range

onready var player_detect = get_node(player_range)
onready var core_detect = get_node(core_range)

func enter() -> void:
  enemy.velocity = Vector2.ZERO

func follow_entity(detect, delta) -> void:
  var target = detect.entity.global_position
  var direction = enemy.global_position.direction_to(target)
  
  enemy.velocity = enemy.velocity.move_toward(direction * follow_speed, delta * follow_acceleration) 
  enemy.velocity = enemy.move_and_slide(enemy.velocity)
  enemy.sprite.flip_h = enemy.velocity.x < 0
  
  
