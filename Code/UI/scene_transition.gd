extends CanvasLayer

onready var animations = $AnimationPlayer

signal show_upgrades 

"""
func change_scene(transition_target : String, transition_type : int):
	match transition_type:
		1:
			# blinds transition
			blind_transition(transition_target)
		2:
			# upgrade transition
			upgrade_transition(transition_target)
		3:
			# return to return transition
			return_transition(transition_target)
		_:
			# in case invalid value is entered
			print("transition does not exist")
"""

func blind_transition(target : String) -> void:
	GameManager.can_pause = false

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animations.play("BlindsTransition")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)

	animations.play_backwards("BlindsTransition")
	yield(animations, "animation_finished")

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.can_pause = true

func upgrade_transition(target : String) -> void:
	GameManager.can_pause = false

	# pauses game for upgrade menu
	var current_pause_state = not get_tree().paused
	get_tree().paused = current_pause_state

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animations.play("UpgradeEnter")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)
	animations.play("UpgradeExit")

	yield(animations, "animation_finished")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# unpauses game to show upgrades
	current_pause_state = not get_tree().paused
	get_tree().paused = current_pause_state

	emit_signal("show_upgrades")
	GameManager.can_pause = true

func return_transition(target : String) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animations.play("ReturnEnter")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)
	animations.play("ReturnExit")

	yield(animations, "animation_finished")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
