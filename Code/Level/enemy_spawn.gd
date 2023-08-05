extends SpawnPoint 

export(int) var wave_cooldown
export(Array, NodePath) var spawn_points
export(Array, String) var wave_codes

var current_wave : int = 0
var current_enemy : int = 0
var enemies_to_spawn : int

var waves_complete: bool = false

var random = RandomNumberGenerator.new()

onready var waveTimer = $WaveTimer

func _ready():
	# setting the current number of enemies supposed to be active, based on entered list
	current_entity_number = wave_codes[current_wave].length()

	waveTimer.start(wave_cooldown)

func _process(delta):
	# continues to spawn until end of array is reached
	if waveTimer.is_stopped() && !waves_complete:
		if spawnTimer.is_stopped() && current_enemy < wave_codes[current_wave].length(): 

			entityID = int(wave_codes[current_wave][current_enemy])

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
			
			if current_wave < wave_codes.size() - 1:
				# next wave
				current_wave += 1

				# to reset number of enemies that will be spawned
				current_entity_number = wave_codes[current_wave].length()

				waveTimer.start(wave_cooldown)
			else:
				# if anything else, final wave must've been reached
				waves_complete = true
