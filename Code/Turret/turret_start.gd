extends TurretBaseState

export(NodePath) var idle_node
export(NodePath) var empty_node

onready var empty_state: TurretBaseState = get_node(empty_node)
onready var idle_state: TurretBaseState = get_node(idle_node)
var animation_finished = false

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
	if turret.ammo <= 0:
		return empty_state
	if animation_finished:
		return idle_state
	
	return null

func start_finished():
	animation_finished = true
