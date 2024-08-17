extends BossBaseState

export(NodePath) var teleport_node
onready var teleport_state = get_node(teleport_node)

export(Array, PackedScene) var entities
export(Array, PackedScene) var heavy_entities
export(Array, PackedScene) var air_entities

export(Array, NodePath) var spawn_points

var entityID: int
var spawnID: int

export(int) var current_entity_number
export(int) var extra_summons

var random = RandomNumberGenerator.new()
var wave_complete: bool
export(int) var spawn_cooldown

# INFO: adding entity number so that it can change depending on the boss' difficulty
var entity_number

export(int) var easy_entity_number
export(int) var hard_entity_number

var enemies_spawned: int

func enter():
	.enter()
	boss.visible = false

	wave_complete = false
	random.randomize()
	entityID = random.randi_range(0, entities.size() - 1)
	enemies_spawned = 0

	if boss.hard_phase:
		current_entity_number = hard_entity_number
		entity_number = hard_entity_number
	else:
		current_entity_number = easy_entity_number
		entity_number = easy_entity_number

	# TODO: summon a heavy ground unit on phase 1, heavy air unit on phase 2
	if boss.boss_phase == 1:
		random.randomize()
		entityID = random.randi_range(0, heavy_entities.size() - 1)

		for i in extra_summons:
			spawnID = random.randi_range(0, spawn_points.size() - 1)
			var spawn_point = get_node(spawn_points[spawnID])

			var entity = heavy_entities[entityID].instance()
			boss.ground_enemy_holder.add_child(entity)
			entity.global_position = spawn_point.global_position

	elif boss.boss_phase >= 2:
		random.randomize()
		entityID = random.randi_range(0, air_entities.size() - 1)

		for i in extra_summons:
			spawnID = random.randi_range(0, spawn_points.size() - 1)
			var spawn_point = get_node(spawn_points[spawnID])

			var entity = air_entities[entityID].instance()
			boss.ground_enemy_holder.add_child(entity)
			entity.global_position = spawn_point.global_position

func process(delta):
	if boss.boss_timer.is_stopped() && (enemies_spawned < entity_number):
		boss.boss_timer.start(spawn_cooldown)

		spawnID = random.randi_range(0, spawn_points.size() - 1)
		var spawn_point = get_node(spawn_points[spawnID])

		var entity = entities[entityID].instance()
		entity.connect("enemy_dead", self, "enemy_down")

		boss.ground_enemy_holder.add_child(entity)
		entity.global_position = spawn_point.global_position

		enemies_spawned += 1

	# TODO: adjust when the boss comes in, two enemies before or one enemy before?
	match boss.boss_phase:
		2:
			if current_entity_number <= 1:
				return teleport_state
		3:
			if current_entity_number <= 2:
				return teleport_state
		_:
			if current_entity_number <= 0:
				return teleport_state

	return null


func enemy_down():
	current_entity_number -= 1
