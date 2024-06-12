extends ItemTurretState

#var electric_cursor = "res://Art/Level/ElectricCursor.png"


func enter() -> void:
	.enter()
	AudioManager.play("AbilitySwitch")


func process(_delta: float) -> ItemBaseState:
	if item.item_control || GameManager.electric_turret_number <= 0:
		return collect_state

	if item.closing:
		return close_state

	if item.shoot_control && place_timer.is_stopped() && item.can_place:
		GameManager.electric_turret_number -= 1
		place_timer.start(place_time)
		place_turret()

	change_cursor()

	return null
