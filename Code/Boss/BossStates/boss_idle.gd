extends BossBaseState

export(NodePath) var ghost_node
export(NodePath) var vending_node 
export(NodePath) var summon_node

onready var ghost_state = get_node(ghost_node)
onready var vending_state = get_node(vending_node)
onready var summon_state = get_node(summon_node)

var random = RandomNumberGenerator.new()

var vending_counter = 0

export(int) var attacks_til_ghost

func enter():
	.enter()
	boss.visible = true

func process(_delta) -> BossBaseState:
	random.randomize()

	var boss_attack = random.randi_range(0,1)
	
	vending_counter += 1
	match boss_attack:
		0:
			return vending_state
		1:
			return summon_state
		_:
			print("unknown attack chosen")

	if vending_counter >= attacks_til_ghost:
		# reset counter
		vending_counter = 0
		return ghost_state

	return null
