extends ItemTurretState

#var electric_cursor = "res://Art/Level/ElectricCursor.png"
export(String, FILE, "*png") var turret_cursor

func enter() -> void:
	.enter()
	Input.set_custom_mouse_cursor(load(turret_cursor), Input.CURSOR_ARROW, Vector2(40, 40))

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
