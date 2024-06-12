extends ItemTurretState

export(NodePath) var electric_node
onready var electric_state = get_node(electric_node)


func enter() -> void:
	.enter()
	AudioManager.play("AbilitySwitch")


func process(_delta: float) -> ItemBaseState:
	if GameManager.ground_turret_number <= 0:
		return collect_state

	if item.item_control:
		return electric_state

	if item.closing:
		return close_state

	if item.shoot_control && place_timer.is_stopped() && item.can_place:
		GameManager.ground_turret_number -= 1
		place_timer.start(place_time)
		place_turret()

	change_cursor()

	return null
