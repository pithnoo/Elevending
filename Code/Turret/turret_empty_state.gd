extends TurretBaseState

export(NodePath) var attack_node
onready var attack_state: TurretBaseState = get_node(attack_node)

signal turret_empty


func enter() -> void:
	.enter()


func process(_delta: float) -> TurretBaseState:
	if turret.ammo > 0:
		return attack_state

	return null


func empty_finished():
	emit_signal("turret_empty")
