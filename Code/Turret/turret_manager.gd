extends Node

export(float) var cooldown
export(int) var startingTurret

export(Array, PackedScene) var turrets
export(NodePath) var other_turret

export(String) var turretInput 
export(String) var manualInput
export(String) var resetInput

var switchInput: bool
var manualControl: bool
var resetControl: bool

onready var switchTimer = $SwitchTimer

var currentTurret
export(int) var currentAmmo = 10

var activeTurret: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_turret(startingTurret)

func _process(delta):

	# so that the keyboard input can be adjusted in editor
	switchInput = Input.is_action_just_pressed(turretInput)
	manualControl = Input.is_action_just_pressed(manualInput)
	resetControl = Input.is_action_just_pressed(resetInput)

	# if one turret is currently manually controlled, then the other turret must be automated
	if manualControl:
		if currentTurret.manualControl == false:
			currentTurret.manualControl = true
			get_node(other_turret).currentTurret.manualControl = false

		elif currentTurret.manualControl == true:
			currentTurret.manualControl = false

		# print("switched")

	# if reset, both turrets should now resume automated attack
	if resetControl:
		print("reset")
		currentTurret.manualControl = false

	if switchInput && switchTimer.is_stopped() && currentTurret.ammo != 0:

		switchTimer.start(cooldown)

		# a reference to where the turret is, passes as a weakref in case turret does not exist yet
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
	# sets the current turret based on array in editor
	currentTurret = turrets[turretIndex].instance()
	add_child(currentTurret)
	currentTurret.ammo = currentAmmo
