extends TurretBaseState

export(NodePath) var attack_node

onready var attack_state: TurretBaseState = get_node(attack_node)

func enter() -> void:
	.enter()

func process(delta: float) -> TurretBaseState:
	return null
