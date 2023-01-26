class_name Enemy
extends KinematicBody2D 

# properties of enemy to be used in game
onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var sprite = $Sprite

var velocity = Vector2.ZERO
export(int) var maxHealth

# variables to be changed by the enemy manager
var health: int

func _ready():
  states.init(self)

func _process(delta):
  states.process(delta)

func _physics_process(delta: float) -> void:
  states.physics_process(delta)
