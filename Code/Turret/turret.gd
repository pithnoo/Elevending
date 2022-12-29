class_name Turret
extends StaticBody2D

# properties of turret to be used in game
onready var attackRange = $AttackRange
onready var animations = $AnimationPlayer
onready var states = $StateManager

# turret variables to be changed by turretManager
var fireRate: float
var damage: float
var ammo: int
export(NodePath) var projectile

# var projectile = predload("res://")

func _ready():
	states.init(self)

# only information that needs to be updated is process
func _process(delta):
	states.process(delta)

