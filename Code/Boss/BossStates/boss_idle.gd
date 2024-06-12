extends BossBaseState

export(float) var hard_cooldown
export(float) var easy_cooldown

export(NodePath) var decide_node
onready var decide_state = get_node(decide_node)

func enter():
	.enter()
	boss.visible = true
	if boss.hard_phase:
		boss.boss_timer.start(hard_cooldown)
	else:
		boss.boss_timer.start(easy_cooldown)

func process(_delta) -> BossBaseState:
	if boss.boss_timer.is_stopped():
		return decide_state

	return null
