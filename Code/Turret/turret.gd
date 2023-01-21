class_name Turret
extends StaticBody2D

# properties of turret to be used in game
onready var attackRange = $AttackRange
onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var rateTimer = $FireRateTimer
var ammo: int

# turret variables to be changed by turretManager
export(PackedScene) var Projectile
export(int) var maxAmmo
export(float) var cooldown 
export(float) var projectileSpeed

func _ready():
  ammo = maxAmmo
  states.init(self)

# only information that needs to be updated is process
func _process(delta):
	states.process(delta)
