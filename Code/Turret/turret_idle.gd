extends TurretBaseState 

export(NodePath) var attack_node

onready var attack_state: TurretBaseState = get_node(attack_node)

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
	# checks if enemy in range, and not out of ammo
	if turret.attackRange.entity_detected() && turret.ammo > 0:
		return attack_state

	return null
