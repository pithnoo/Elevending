extends CanvasLayer

onready var animations = $AnimationPlayer

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

func blind_transition(target : String) -> void:
	animations.play("BlindsTransition")
	yield(animations, "animation_finished")
	get_tree().change_scene(target)
	animations.play_backwards("BlindsTransition")

func upgrade_transition(target : String) -> void:
	animations.play("UpgradeEnter")
	yield(animations, "animation_finished")
	get_tree().change_scene(target)
	animations.play("UpgradeExit")

func return_transition(target : String) -> void:
	animations.play("ReturnEnter")
	yield(animations, "animation_finished")
	get_tree().change_scene(target)
	animations.play("ReturnExit")
