extends EnemyFollowState

export(NodePath) var follow_node
export(NodePath) var player_range

onready var follow_state: EnemyBaseState = get_node(follow_node)
onready var player_detect = get_node(player_range)


func enter() -> void:
	.enter()


func physics_process(delta: float) -> EnemyBaseState:
	if player_detect.entity_detected():
		follow_entity(player_detect, delta)
	else:
		return follow_state

	return null
