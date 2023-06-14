extends EnemyFollowState 

export(NodePath) var idle_node
export(NodePath) var core_range

onready var idle_state: EnemyBaseState = get_node(idle_node)
onready var core_detect = get_node(core_range)

func enter() -> void:
  .enter()

func physics_process(delta: float) -> EnemyBaseState:
  if core_detect.entity_detected():
	  follow_entity(core_detect, delta)
  else:
	  return idle_state

  return null 
