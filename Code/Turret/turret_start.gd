extends TurretBaseState

export(NodePath) var idle_node
export(NodePath) var empty_node

onready var empty_state: TurretBaseState = get_node(empty_node)
onready var idle_state: TurretBaseState = get_node(idle_node)
var animation_finished

export(bool) var will_place = false

func enter() -> void:
	.enter()
	animation_finished = false
	AudioManager.play("TurretPlace")

func process(_delta: float) -> TurretBaseState:
	if animation_finished:
		if turret.ammo <= 0:
			return empty_state
		else:
			return idle_state
	
	return null

func start_finished():
	animation_finished = true
