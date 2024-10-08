extends CanvasLayer

onready var animations = $AnimationPlayer

signal show_upgrades

var can_press: bool = false

export(NodePath) var particle_position_node
onready var particle_position = get_node(particle_position_node)
export(NodePath) var boss_particle_position_node
onready var boss_particle_position = get_node(boss_particle_position_node)

export(PackedScene) var destroy_effect
export(Array, PackedScene) var boss_effects

var game_over: bool = false

onready var screen_shake = $ScreenShake
onready var transition_camera = $TransitionCamera

signal transition_shake

func fade_transition(target: String) -> void:
	animations.play("FadeTransition")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)
	animations.play_backwards("FadeTransition")
	yield(animations, "animation_finished")
	
func blind_transition(target: String) -> void:
	AudioManager.play("BlindTransition")
	GameManager.can_pause = false

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animations.play("BlindsTransition")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)

	animations.play_backwards("BlindsTransition")
	yield(animations, "animation_finished")

	GameManager.change_game_cursor(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func upgrade_transition(target: String) -> void:
	# WARNING: this should be set if the tutorial panel isn't called
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

func return_transition(target: String) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animations.play("ReturnEnter")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)
	animations.play("ReturnExit")

	yield(animations, "animation_finished")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func over_transition(target: String) -> void:
	GameManager.level_select_first = true
	get_tree().paused = true

	AudioManager.play("BlindTransition")
	GameManager.can_pause = false

	animations.play("GameOver")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)

	can_press = true
	GameManager.change_game_cursor(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func boss_transition(target: String) -> void:
	GameManager.level_select_first = true
	get_tree().paused = true

	AudioManager.play("BlindTransition")
	GameManager.can_pause = false

	animations.play("BossOver")
	yield(animations, "animation_finished")

	get_tree().change_scene(target)

	can_press = true
	GameManager.change_game_cursor(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func game_over_effect() -> void:
	AudioManager.play("GameOver")
	transition_camera.current = true
	screen_shake.apply_shake()

	var effect = destroy_effect.instance()

	particle_position.add_child(effect)
	effect.global_position = particle_position.global_position

func boss_effect() -> void:
	AudioManager.play("GameOver")
	transition_camera.current = true
	screen_shake.apply_shake()

	for boss_effect in boss_effects:
		var effect = boss_effect.instance()
		boss_particle_position.add_child(effect)
		effect.global_position = boss_particle_position.global_position

func _on_MenuButton_pressed():
	animations.play_backwards("GameReturn")
	can_press = false

	yield(animations, "animation_finished")
	get_tree().paused = false

	AudioManager.play("Soba")
	AudioManager.current_theme = "Soba"

func _on_MenuButton2_pressed():
	animations.play_backwards("BossReturn")
	can_press = false

	yield(animations, "animation_finished")
	get_tree().paused = false

	AudioManager.play("Soba")
	AudioManager.current_theme = "Soba"

func unpause():
	if not GameManager.has_tutorial:
		get_tree().paused = false
		GameManager.can_pause = true

