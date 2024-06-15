extends BossBaseState

export(NodePath) var ghost_node
export(NodePath) var vending_node
export(NodePath) var summon_node
export(int) var attacks_til_ghost

onready var ghost_state = get_node(ghost_node)
onready var vending_state = get_node(vending_node)
onready var summon_state = get_node(summon_node)

var random = RandomNumberGenerator.new()
var attack_counter = 0

var teleport_finished : bool = false

func disappear():
	boss.visible = false
	teleport_finished = true

func enter():
	teleport_finished = false
	.enter()

func process(_delta) -> BossBaseState:
	if teleport_finished == true:
		random.randomize()

		var boss_attack = random.randi_range(0, 1)
		boss_attack = 0

		attack_counter += 1

		if attack_counter > attacks_til_ghost:
			attack_counter = 0
			return ghost_state

		match boss_attack:
			0:
				if boss.vending_remains:
					return summon_state
				else:
					return vending_state
			1:
				return summon_state
			_:
				print("unknown attack chosen, check ranges in decision state")

	return null
