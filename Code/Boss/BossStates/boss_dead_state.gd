extends BossBaseState

export(String, FILE, "*.tscn,*.scn") var menu

signal rate_boss_level

var animation_finished: bool

func enter():
	.enter()

	AudioManager.stop_playing(AudioManager.current_theme)

	# don't play menu theme until player returns
	GameManager.play_menu_theme = false

	GameManager.can_pause = false
	boss.pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true
	animation_finished = false
	AudioManager.play("CoreDown")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func animation_finished():
	emit_signal("rate_boss_level")
	animation_finished = true
	SceneTransition.boss_transition(menu)
	boss.pause_mode = Node.PAUSE_MODE_INHERIT

func process(delta):
	if animation_finished:
		queue_free()
