extends EnemyFollowState 

export(NodePath) var idle_node
export(NodePath) var stun_node
export(NodePath) var core_range

onready var idle_state: EnemyBaseState = get_node(idle_node)
onready var stun_state: EnemyBaseState = get_node(stun_node)
onready var core_detect = get_node(core_range)

func enter() -> void:
  .enter()

func physics_process(delta: float) -> EnemyBaseState:
	if enemy.is_stunned:
		return stun_state
	elif core_detect.entity_detected():
		follow_entity(core_detect, delta)
	else:
		return idle_state

	return null 
