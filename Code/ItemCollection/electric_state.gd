extends ItemTurretState

var electric_cursor

func enter() -> void:
	.enter()
	set_cursor(electric_cursor)

func process(_delta: float) -> ItemBaseState:
	if item.item_control || GameManager.electric_turret_number <= 0:
		return collect_state

	if item.closing:
		return close_state

	if item.shoot_control && place_timer.is_stopped():
		GameManager.electric_turret_number -= 1
		place_timer.start(place_time)
		place_turret()
		
	return null
