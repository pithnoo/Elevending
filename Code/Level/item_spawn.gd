extends SpawnPoint

export(NodePath) var item_holder_node
onready var item_holder = get_node(item_holder_node)

export(int) var crates_before_reload
var items_since_reload: int = 0

export(int) var max_existing_items
var current_number_items: int = 0

export(float) var distance_between_items

onready var spawn_area = $SpawnArea

export(NodePath) var wave_spawn_node
onready var wave_spawner = get_node(wave_spawn_node)

var can_spawn_items: bool = false

export(bool) var boss_spawner = false

var current_item_positions: Array
var prev_point = Vector2.ZERO

func _process(delta):
	if wave_spawn_node == "":
		can_spawn_items = true
	elif !boss_spawner:
		can_spawn_items = wave_spawner.can_items_spawn
	else:
		# This is for the boss.gd file, which only has this boolean
		can_spawn_items = wave_spawner.boss_items_spawn

	if can_spawn_items:
		if spawnTimer.is_stopped():
			items_since_reload += 1

			var random = RandomNumberGenerator.new()
			random.randomize()

			if items_since_reload >= crates_before_reload:
				entityID = 0
				items_since_reload = 0
			else:
				entityID = random.randi_range(0, entities.size() - 1)

			if current_number_items < max_existing_items:
				spawn(entityID, gen_random_pos())
			else:
				spawnTimer.start(spawn_cooldown)

func gen_random_pos():
	var random = RandomNumberGenerator.new()
	random.randomize()

	var current_point = (
		 spawn_area.rect_position
		 + Vector2(randf() * spawn_area.rect_size.x, randf() * spawn_area.rect_size.y)
	)

	for prev_point in current_item_positions:
		if current_point.distance_to(prev_point) < distance_between_items:
			# too close
			# generate another point recursively until correct point is found
			current_point = gen_random_pos()
			return current_point

	#print(current_item_positions)

	current_item_positions.append(current_point)

	return current_point


func spawn(index: int, spawnPoint) -> void:
	current_number_items += 1
	spawnTimer.start(spawn_cooldown)

	var entity = entities[index].instance()
	entity.connect("used", self, "item_used")

	item_holder.add_child(entity)

	entity.global_position = spawnPoint


func item_used(item_position) -> void:
	current_number_items -= 1

	for position in current_item_positions:
		if item_position.global_position == position:
			current_item_positions.erase(position)
			break
