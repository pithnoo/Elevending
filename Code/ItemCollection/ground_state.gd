extends ItemTurretState

export(NodePath) var electric_node
onready var electric_state = get_node(electric_node)

var ground_cursor

func enter() -> void:
	.enter()
	set_cursor(ground_cursor)

func process(_delta: float) -> ItemBaseState:
	if item.item_control:
		return electric_state

	if item.closing:
		return close_state

	if item.shoot_control && place_timer.is_stopped():
		place_timer.start(place_time)
		place_turret()

	return null
