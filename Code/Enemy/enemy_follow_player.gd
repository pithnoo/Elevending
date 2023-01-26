extends EnemyFollowState 

export(NodePath) var follow_core_node
export(NodePath) var idle_node

onready var follow_core_state: EnemyFollowState = get_node(follow_core_node)
onready var idle_state: EnemyBaseState = get_node(idle_node)

func enter() -> void:
  .enter()

func physics_process(delta: float) -> EnemyBaseState:
  if player_detect.entity_detected():
    follow_entity(player_detect, delta)
  elif core_detect.entity_detected():
    return follow_core_state
  else:
	  return idle_state

  return null 
