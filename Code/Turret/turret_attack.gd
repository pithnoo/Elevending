extends TurretBaseState 

export(NodePath) var idle_node

onready var idle_state: TurretBaseState = get_node(idle_node)

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
	if turret.attackRange.entity_detected():
		# shoot at enemy
		pass
	else:
		return idle_state
	return null
