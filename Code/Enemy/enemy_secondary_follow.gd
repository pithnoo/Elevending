extends EnemyFollowState 

export(NodePath) var idle_node
export(NodePath) var attack_node

export(NodePath) var core_range
export(NodePath) var attack_range

onready var core_detect = get_node(core_range)
onready var attack_detect = get_node(attack_range)

onready var idle_state: EnemyBaseState = get_node(idle_node)
onready var attack_state: EnemyBaseState = get_node(attack_node)

func enter() -> void:
	.enter()
	enemy.velocity = Vector2.ZERO

func physics_process(delta: float) -> EnemyBaseState:
	if attack_detect.entity_detected():
		return attack_state
	elif core_detect.entity_detected():
		follow_entity(core_detect, delta)
	else:
		return idle_state

	return null
