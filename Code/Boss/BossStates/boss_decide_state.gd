extends BossBaseState

export(NodePath) var ghost_node
export(NodePath) var vending_node
export(NodePath) var summon_node
export(int) var easy_attacks_til_ghost
export(int) var hard_attacks_til_ghost

onready var ghost_state = get_node(ghost_node)
onready var vending_state = get_node(vending_node)
onready var summon_state = get_node(summon_node)

var random = RandomNumberGenerator.new()
var attack_counter = 0

var teleport_finished : bool = false

export(PackedScene) var warp_particle

func disappear():
	var particle = warp_particle.instance()
	particle.global_position = boss.global_position
	boss.visible = false
	add_child(particle)
	teleport_finished = true

func enter():
	.enter()
	teleport_finished = false
	AudioManager.play("BossWarp")
	
func process(_delta) -> BossBaseState:
	if teleport_finished == true:
		random.randomize()

		var boss_attack = random.randi_range(0, 1)
		boss_attack = 0

		attack_counter += 1

		match boss.boss_phase:
			2:
				if attack_counter > hard_attacks_til_ghost:
					attack_counter = 0
					return ghost_state
			_:
				if attack_counter > easy_attacks_til_ghost:
					attack_counter = 0
					return ghost_state

		match boss_attack:
			0:
				if boss.vending_remains || boss.vending_before:
					boss.vending_before = false
					return summon_state
				else:
					boss.vending_before = true
					return vending_state
			1:
				return summon_state
			_:
				print("unknown attack chosen, check ranges in decision state")

	return null
