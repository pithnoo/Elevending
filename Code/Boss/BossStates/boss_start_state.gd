extends BossBaseState

export(NodePath) var idle_node
onready var idle_state = get_node(idle_node)

export(PackedScene) var boss_shadow

var animation_finished : bool
var boss_travelling = false
var travel_right = true

export(Array, PackedScene) var effect_particle
var effect_order : int

func animation_finished(): animation_finished = true

func travel_start():
	AudioManager.play("BossWhoosh")
	GameManager.can_pause = false
	get_tree().paused = true
	boss_travelling = true
	boss.pause_mode = Node.PAUSE_MODE_PROCESS

func travel_finished(): boss_travelling = false 

func start_finished():
	get_tree().paused = false
	boss.pause_mode = Node.PAUSE_MODE_INHERIT
	animation_finished = true
	GameManager.can_pause = true

func travel_back():
	AudioManager.play("BossWhoosh")
	travel_right = false

func boss_effect():
	var particle = effect_particle[effect_order].instance()
	particle.global_position = boss.global_position
	add_child(particle)
	effect_order += 1
	AudioManager.play("BossWarp")

func enter():
	.enter()
	animation_finished = false
	effect_order = 0

func process(delta):
	if boss_travelling && boss.shadow_timer.is_stopped():
		boss.shadow_timer.start(0.05)
		var entity = boss_shadow.instance()
		entity.global_position = boss.global_position
		boss.ground_enemy_holder.add_child(entity)	
		entity.pause_mode = Node.PAUSE_MODE_PROCESS

		if !travel_right:
			entity.scale.x = -1
		else:
			entity.scale.x = 1

	if animation_finished:
		boss.can_items_spawn = true
		return idle_state
