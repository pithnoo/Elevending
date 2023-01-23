extends EnemyBaseState 

export(NodePath) var follow_core_node
export(NodePath) var idle_node
export(float) var followSpeed
export(float) var followAcceleration

onready var follow_core_state: EnemyBaseState = get_node(follow_core_node)
onready var idle_state: EnemyBaseState = get_node(idle_node)

func enter() -> void:
  .enter()

func physics_process(delta: float) -> EnemyBaseState:
  if enemy.playerDetection.entity_detected():
    var player = enemy.playerDetection.entity.global_position
    var direction = enemy.global_position.direction_to(player)

    enemy.velocity = enemy.velocity.move_toward(direction * followSpeed, delta * followAcceleration) 
    enemy.velocity = enemy.move_and_slide(enemy.velocity)
    enemy.sprite.flip_h = enemy.velocity.x < 0
  else:
	  return idle_state

  return null 
