class_name Turret
extends StaticBody2D

# properties of turret to be used in game
onready var attackRange = $AttackRange
onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var rateTimer = $FireRateTimer
onready var firePoint = $FirePoint

# ammo is set in turret_manager
var ammo: int

# by default, turret should not be manually controlled
var manualControl: bool = false

# turret variables to be changed by turretManager
export(PackedScene) var Projectile
export(PackedScene) var projectileEffect 
export(float) var cooldown 

func _ready():
  states.init(self)

# only information that needs to be updated is process
func _process(delta):
	states.process(delta)
