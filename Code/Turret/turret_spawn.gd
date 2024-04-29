extends TurretBaseState

export(NodePath) var start_node
export(NodePath) var manual_node

onready var start_state = get_node(start_node)
onready var manual_state = get_node(manual_node)

func enter():
	.enter()

func process(delta):
	if turret.manualControl == true:
		return manual_state

	return start_state
