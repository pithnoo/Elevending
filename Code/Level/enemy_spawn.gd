extends SpawnPoint 

export(Array, NodePath) var spawn_points
export(Array, String) var wave_codes

var current_wave : int = 0
var current_enemy : int = 0


func _process(delta):
	# checking cooldown, and if all waves are completed
	if spawnTimer.is_stopped() && current_wave < wave_codes.size():

		var random = RandomNumberGenerator.new()
		random.randomize()

		entityID = int(wave_codes[current_wave][current_enemy])

		# selects random spawn point value
		spawnID = random.randi_range(0, spawn_points.size()-1)
	
		# to spawn a random entity, based on a list of given points
		spawn(entityID, get_node(spawn_points[spawnID]))

		# moves onto next enemy on wave sequence
		current_enemy += 1

		if current_enemy == wave_codes[current_wave].length():
			# reset enemy counter, first enemy of wave
			current_enemy = 0

			# next wave
			current_wave += 1

		if current_wave == wave_codes.size():
			# emit signal that waves are complete
			print("waves complete")
