extends BossBaseState

export(NodePath) var idle_node
onready var idle_state = get_node(idle_node)

var animation_finished: bool


func enter():
	.enter()
	animation_finished = false


func animation_finished():
	animation_finished = true


func process(delta):
	if animation_finished:
		return idle_state
