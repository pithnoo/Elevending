extends BossBaseState

export(NodePath) var teleport_node
onready var teleport_state = get_node(teleport_node)

export(NodePath) var hurt_node
onready var hurt_state = get_node(hurt_node)

export(PackedScene) var fire_machine
export(PackedScene) var water_machine
export(PackedScene) var grass_machine

const ELEMENTS = 3
const LEFT = 4 
const RIGHT = 5

export(NodePath) var left_attack
onready var left_attack_position = get_node(left_attack).global_position
export(NodePath) var right_attack
onready var right_attack_position = get_node(right_attack).global_position

# WARNING: i'll lay this out l1,r1,l2,r2

export(Array, NodePath) var attack_position_nodes
var attack_positions : Array

var random = RandomNumberGenerator.new()
var summon_counter: int
var summon_quota : int
var success_counter: int

func enter():
	.enter()
	boss.visible = false

	# resetting boss stats on each entry
	success_counter = 0
	summon_counter = 0
	summon_quota = 0

	for node in attack_position_nodes:
		attack_positions.append(get_node(node).global_position)


	match boss.boss_phase:
		2:
			summon_counter += 2
			summon_quota = 2
			decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[0], LEFT)
			decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[1], RIGHT)
		3:
			summon_counter += 4
			summon_quota = 4
			decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[0], LEFT)
			decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[2], LEFT)
			decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[1], RIGHT)
			decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[3], RIGHT)
		_:
			summon_counter += 1
			summon_quota = 1
			var launcher_side = random.randi_range(0, 1)
			if launcher_side == 0:
				decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[0], LEFT)
			else:
				decide_spawn(random.randi_range(0, ELEMENTS-1), attack_positions[1], RIGHT)

func process(delta):
	# INFO: if no more machines are remaining, then the boss has been damaged
	if summon_counter <= 0:
		if success_counter >= summon_quota:
			return hurt_state
		else:
			return teleport_state
	return null

func decide_spawn(element : int, spawn_position, direction : int):
	match element:
		0:
			spawn(fire_machine, spawn_position, direction)
		1:
			spawn(water_machine, spawn_position, direction)
		2:
			spawn(grass_machine, spawn_position, direction)
		_:
			print("unknown element chosen, check array range")
				
func spawn(machine, spawn_position, direction : int):
	var entity = machine.instance()
	var main = get_tree().current_scene
	main.add_child(entity)

	entity.connect("launcher_destroyed", self, "machine_down")
	entity.connect("launcher_ready", self, "machine_launched")

	entity.global_position = spawn_position

	if direction == RIGHT:
		# TODO: flip the sprite so that it faces the right direction
		entity.scale.x = -1
		entity.flip_machine()
	
	match boss.boss_phase:
		2:
			entity.stats.set_health(2)
		3:
			entity.stats.set_health(1)
		_:
			entity.stats.set_health(3)

func machine_down():
	summon_counter -= 1
	success_counter += 1

func machine_launched():
	summon_counter -= 1
