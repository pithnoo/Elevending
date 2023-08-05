class_name SpawnPoint
extends Node

export(int) var spawn_cooldown 

# list of entities to spawn
export(Array, PackedScene) var entities

export(int) var current_entity_number

# spawn cooldown
onready var spawnTimer = $SpawnTimer

var spawnID: int
var entityID: int 

func spawn(index: int, spawnPoint) -> void:
	spawnTimer.start(spawn_cooldown)

	var entity = entities[index].instance()
	entity.connect("enemy_dead", self, "enemy_down")

	add_child(entity)
	
	entity.global_position = spawnPoint.global_position

func enemy_down() -> void:
	current_entity_number -= 1
