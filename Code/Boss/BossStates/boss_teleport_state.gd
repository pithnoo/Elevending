extends BossBaseState

export(NodePath) var idle_node
onready var idle_state = get_node(idle_node)

export(NodePath) var idle_position_node
onready var idle_position = get_node(idle_position_node).global_position

var teleport_finished : bool = false

func enter():
	.enter()
	boss.global_position = idle_position
	boss.visible = true
	
func disappear():
	boss.visible = false
	teleport_finished = true

func process(delta):
	if teleport_finished:
		return idle_state
