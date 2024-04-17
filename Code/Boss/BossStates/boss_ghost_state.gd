extends BossBaseState

export(PackedScene) var fire_machine
export(PackedScene) var water_machine
export(PackedScene) var grass_machine

export(NodePath) var left_attack
export(NodePath) var right_attack

var summon_counter : int

func enter():
	.enter()

func process(delta):
	# TODO: summon both machines and connect destroy signal
	return null	

func machine_down():
	# TODO: connect this to the summoned machine
	summon_counter -= 1
