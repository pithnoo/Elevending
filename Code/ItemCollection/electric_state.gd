extends ItemTurretState

export(NodePath) var collect_node
onready var collect_state = get_node(collect_node)

var electric_cursor

func enter() -> void:
	.enter()
	set_cursor(electric_cursor)

func process(_delta: float) -> ItemBaseState:
	if item.item_control:
		return collect_state

	if item.closing:
		return close_state

	if item.shoot_control && place_timer.is_stopped():
		place_timer.start(place_time)
		place_turret()
		
	return null
