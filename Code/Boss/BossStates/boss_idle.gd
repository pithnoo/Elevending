extends BossBaseState

export(NodePath) var ghost_node
export(NodePath) var vending_node 
export(NodePath) var summon_node

onready var ghost_state = get_node(ghost_node)
onready var vending_state = get_node(vending_node)
onready var summon_state = get_node(summon_node)

var random = RandomNumberGenerator.new()

func enter():
	.enter()

func process(_delta) -> BossBaseState:
	# WARNING: if working with the vending state, be sure to have a counter
	random.randomize()

	var boss_attack = random.randi_range(0,1)
	
	match boss_attack:
		0:
			print("ghost entered")
			return ghost_state
		1:
			return vending_state
		2:
			return summon_state
		_:
			print("unknown attack chosen")

	return null
