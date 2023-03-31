class_name Turret
extends StaticBody2D

# properties of turret to be used in game
onready var attackRange = $AttackRange
onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var rateTimer = $FireRateTimer
onready var firePoint = $FirePoint
var ammo: int

# turret variables to be changed by turretManager
export(PackedScene) var Projectile
export(PackedScene) var projectileEffect 
export(int) var maxAmmo
# export(float) var projectileSpeed
export(float) var cooldown 

func _ready():
  ammo = maxAmmo
  states.init(self)

# only information that needs to be updated is process
func _process(delta):
	states.process(delta)
