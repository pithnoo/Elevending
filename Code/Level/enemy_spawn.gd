extends SpawnPoint 

export(int) var wave_cooldown
export(Array, NodePath) var spawn_points

# variables used to convert user entered wave codes to be read
export(Array, String) var wave_holder
var waves_to_spawn : Array
var wave_value : String
var wave_store : Array

# used to decide the length of each wave (current_entity_number)
var wave_lengths : Array

# this is what is read to start waves
# of type int
var wave_codes : Array

export(NodePath) var ground_enemy_holder_node
onready var ground_enemy_holder = get_node(ground_enemy_holder_node)

export(NodePath) var air_enemy_holder_node 
onready var air_enemy_holder = get_node(air_enemy_holder_node)

var current_enemy : int = 0
var enemies_to_spawn : int

var waves_complete : bool = false
var can_items_spawn : bool = false
var can_enemies_spawn : bool

var random = RandomNumberGenerator.new()

var enemy_counter : int = 0

onready var waveTimer = $WaveTimer

func _ready():
	waveTimer.start(wave_cooldown)

	GameManager.display_wave()

	can_enemies_spawn = true

	for waves in wave_holder:
		for value in waves:
			if value == " ":
				waves_to_spawn.append(wave_value)
				wave_value = ""
			else:
				wave_value += value

		waves_to_spawn.append(wave_value)
		wave_value = ""

		var wave_buffer = waves_to_spawn.duplicate()

		wave_codes.append(wave_buffer)
		wave_lengths.append(wave_buffer.size())
		enemy_counter += wave_buffer.size()

		waves_to_spawn.clear()

	# setting the current number of enemies supposed to be active, based on entered list
	current_entity_number = wave_lengths[GameManager.current_wave]

	#print(wave_codes)
	print("total enemy count: ", enemy_counter)
	
func _process(delta):
	# continues to spawn until end of array is reached
	if waveTimer.is_stopped() && !waves_complete:

		GameManager.emit_signal("start_wave")

		can_items_spawn = true

		if spawnTimer.is_stopped() && current_enemy < wave_lengths[GameManager.current_wave]: 
			entityID = int(wave_codes[GameManager.current_wave][current_enemy])

			random.randomize()

			# selects random spawn point value
			spawnID = random.randi_range(0, spawn_points.size()-1)
		
			# to spawn a random entity, based on a list of given points
			spawn(entityID, get_node(spawn_points[spawnID]))

			# moves onto next enemy on wave sequence
			current_enemy += 1
			
		if current_entity_number <= 0:
			# reset enemy counter, first enemy of wave
			current_enemy = 0

			can_items_spawn = false
			
			if GameManager.current_wave < wave_codes.size() - 1:
				# next wave
				GameManager.current_wave += 1

				# to reset number of enemies that will be spawned
				#current_entity_number = wave_codes[GameManager.current_wave].length()
				current_entity_number = wave_lengths[GameManager.current_wave]

				waveTimer.start(wave_cooldown)

				GameManager.display_wave()

				can_items_spawn = false
			else:
				# if anything else, final wave must've been reached
				waves_complete = true

				can_items_spawn = false

				# level complete
				GameManager.emit_signal("level_complete")

func spawn(index: int, spawnPoint) -> void:
	spawnTimer.start(spawn_cooldown)

	var entity = entities[index].instance()
	entity.connect("enemy_dead", self, "enemy_down")

	# for layering
	# all ground units have an index lower than 8
	if index > 8:
		ground_enemy_holder.add_child(entity)
	# if the index is greater than 8, then enemy to spawn must be an air unit
	else:
		air_enemy_holder.add_child(entity)
	
	entity.global_position = spawnPoint.global_position

func enemy_down() -> void:
	current_entity_number -= 1
