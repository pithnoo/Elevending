extends BossBaseState 

export(NodePath) var idle_node
onready var idle_state = get_node(idle_node)

export(NodePath) var idle_position_node
onready var idle_position = get_node(idle_position_node).global_position

export(float) var hard_cooldown
export(float) var easy_cooldown

func enter():
	.enter()
	boss.global_position = idle_position

	if boss.hard_phase:
		boss.boss_timer.start(hard_cooldown)
	else:
		boss.boss_timer.start(easy_cooldown)

func disappear():
	boss.visible = false

func process(delta):
	if boss.boss_timer.is_stopped():
		return idle_state
