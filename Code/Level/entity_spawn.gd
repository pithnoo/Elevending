class_name SpawnPoint
extends Node

export(int) var spawn_cooldown 

# list of entities to spawn
export(Array, PackedScene) var entities

# spawn cooldown
onready var spawnTimer = $SpawnTimer

var spawnID: int
var entityID: int 

func spawn(index: int, spawnPoint) -> void:
	spawnTimer.start(spawn_cooldown)

	var entity = entities[index].instance()
	add_child(entity)
	
	entity.global_position = spawnPoint.global_position
