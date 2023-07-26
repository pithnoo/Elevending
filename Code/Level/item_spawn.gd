extends SpawnPoint 

export(int) var crates_before_reload 
var items_since_reload: int = 0

	
func _process(delta):
	if spawnTimer.is_stopped():
		items_since_reload += 1

		print("generated")

		var random = RandomNumberGenerator.new()
		random.randomize()

		entityID = random.randi_range(0, entities.size())
