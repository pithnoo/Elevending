class_name Player
extends KinematicBody2D

var can_dash: bool = true

onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var sprite = $Sprite

var velocity = Vector2.ZERO
var facing_direction: int

func _ready() -> void:
	states.init(self)

func _input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
