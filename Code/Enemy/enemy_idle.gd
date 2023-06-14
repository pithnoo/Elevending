extends EnemyBaseState

export(NodePath) var follow_node
export(NodePath) var player_range
export(NodePath) var core_range

onready var follow_state = get_node(follow_node)
onready var player_detect = get_node(player_range)
onready var core_detect = get_node(core_range)

func enter() -> void:
  .enter()
  enemy.velocity = Vector2.ZERO

func process(_delta: float) -> EnemyBaseState:
	if core_detect.entity_detected() || player_detect.entity_detected():
		return follow_state
	return null
