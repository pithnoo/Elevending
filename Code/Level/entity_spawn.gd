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
