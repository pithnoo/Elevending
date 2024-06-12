class_name Player
extends KinematicBody2D

var can_dash: bool = true

onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var sprite = $Sprite

var velocity = Vector2.ZERO
var facing_direction: int

export(PackedScene) var deathEffect


func _ready() -> void:
	states.init(self)


func _input(event: InputEvent) -> void:
	states.input(event)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func _on_Stats_no_health():
	# instantiate death effect
	var effect = deathEffect.instance()
	var main = get_tree().current_scene

	main.add_child(effect)
	effect.global_position = global_position

	queue_free()
