extends SpawnPoint 

export(int) var wave_cooldown
export(Array, NodePath) var spawn_points
export(Array, String) var wave_codes

# var current_wave : int = 0

var current_enemy : int = 0
var enemies_to_spawn : int

var waves_complete : bool = false
var can_items_spawn : bool = false

var random = RandomNumberGenerator.new()

onready var waveTimer = $WaveTimer

func _ready():
	# setting the current number of enemies supposed to be active, based on entered list
	current_entity_number = wave_codes[GameManager.current_wave].length()

	waveTimer.start(wave_cooldown)

	#GameManager.emit_signal("show_wave", current_wave + 1)
	GameManager.display_wave()

func _process(delta):
	# continues to spawn until end of array is reached
	if waveTimer.is_stopped() && !waves_complete:

		GameManager.emit_signal("start_wave")

		can_items_spawn = true

		if spawnTimer.is_stopped() && current_enemy < wave_codes[GameManager.current_wave].length(): 
			entityID = int(wave_codes[GameManager.current_wave][current_enemy])

			random.randomize()

			# selects random spawn point value
			spawnID = random.randi_range(0, spawn_points.size()-1)
		
			# to spawn a random entity, based on a list of given points
			spawn(entityID, get_node(spawn_points[spawnID]))

			# moves onto next enemy on wave sequence
			current_enemy += 1
			
		if current_entity_number == 0:
			# reset enemy counter, first enemy of wave
			current_enemy = 0

			can_items_spawn = false
			
			if GameManager.current_wave < wave_codes.size() - 1:
				# next wave
				GameManager.current_wave += 1

				#GameManager.emit_signal("show_wave", current_wave + 1)
				GameManager.display_wave()

				# to reset number of enemies that will be spawned
				current_entity_number = wave_codes[GameManager.current_wave].length()

				waveTimer.start(wave_cooldown)
			else:
				# if anything else, final wave must've been reached
				waves_complete = true

				# level complete
				can_items_spawn = false


func spawn(index: int, spawnPoint) -> void:
	spawnTimer.start(spawn_cooldown)

	var entity = entities[index].instance()
	entity.connect("enemy_dead", self, "enemy_down")

	add_child(entity)
	
	entity.global_position = spawnPoint.global_position

func enemy_down() -> void:
	current_entity_number -= 1
