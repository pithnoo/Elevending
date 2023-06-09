extends Node

export(float) var cooldown
export(int) var startingTurret
export(Array, PackedScene) var turrets

export(String) var turretInput 

var switchInput

onready var switchTimer = $SwitchTimer

var currentTurret
var currentAmmo: int = 10
var activeTurret: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_turret(startingTurret)

func _process(delta):

	switchInput = Input.is_action_just_pressed(turretInput)

	if switchInput && switchTimer.is_stopped() && currentTurret.ammo != 0:

		switchTimer.start(cooldown)

		var wr = weakref(currentTurret)
		if wr.get_ref():
			currentTurret.queue_free()
			currentAmmo = currentTurret.ammo

		activeTurret += 1

		if activeTurret > 2:
			activeTurret = 0
			switch_turret(activeTurret)
		else:
			switch_turret(activeTurret)

func switch_turret(turretIndex: int):
	currentTurret = turrets[turretIndex].instance()
	add_child(currentTurret)
	currentTurret.ammo = currentAmmo
