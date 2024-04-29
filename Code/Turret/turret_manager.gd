extends Node

onready var boostTimer = $BoostTimer
export(int) var boostTime
var has_boosted : bool = false

export(float) var fireRate
var fireRateBuffer

export(float) var cooldown
export(int) var startingTurret

export(Array, PackedScene) var turrets
export(NodePath) var other_turret

export(String) var turretInput 
export(String) var manualInput
export(String) var resetInput
export(String) var itemInput

var switchInput: bool
var manualControl: bool
var resetControl: bool
var itemControl: bool

onready var switchTimer = $SwitchTimer

var currentTurret
export(int) var maxAmmo = 10
var currentAmmo : int
var currentManual : bool

var activeTurret : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	fireRateBuffer = fireRate
	currentAmmo = maxAmmo
	switch_turret(startingTurret)

	# connecting signals from level manager
	GameManager.connect("ammo_reload", self, "turret_reload")
	GameManager.connect("fire_rate_doubled", self, "increase_fire_rate")

func _process(delta):

	if boostTimer.is_stopped():
		fireRate = fireRateBuffer

		currentTurret.cooldown = fireRateBuffer
		currentTurret.decreaseAmmo = true

		has_boosted = false

	# so that the keyboard input can be adjusted in editor
	switchInput = Input.is_action_just_pressed(turretInput)
	manualControl = Input.is_action_just_pressed(manualInput)
	resetControl = Input.is_action_just_pressed(resetInput)

	# to set both turrets as inactive to collect items
	itemControl = Input.is_action_just_pressed(itemInput)

	# if one turret is currently manually controlled, then the other turret must be automated
	if manualControl:
		GameManager.is_manual = true

		if currentTurret.manualControl == false:
			currentTurret.manualControl = true
			get_node(other_turret).currentTurret.manualControl = false

		elif currentTurret.manualControl == true:
			currentTurret.manualControl = false

	# if reset, both turrets should now resume automated attack
	if resetControl || itemControl:
		currentTurret.manualControl = false
		GameManager.is_manual = false

	if switchInput && switchTimer.is_stopped() && currentTurret.ammo != 0:

		switchTimer.start(cooldown)

		# a reference to where the turret is, passes as a weakref in case turret does not exist yet
		var wr = weakref(currentTurret)

		if wr.get_ref():
			currentTurret.queue_free()
			currentAmmo = currentTurret.ammo
			currentManual = currentTurret.manualControl

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
	currentTurret.cooldown = fireRate
	currentTurret.manualControl = currentManual

	GameManager.is_manual = false

func turret_reload():
	currentTurret.power_up()
	currentTurret.ammo = maxAmmo

func increase_fire_rate():
	if !has_boosted:
		has_boosted = true

		currentTurret.power_up()
		currentTurret.decreaseAmmo = false

		fireRateBuffer = currentTurret.cooldown
		fireRate /= 2
		currentTurret.cooldown = fireRate

	# if the turret has already increased, then just prolong the boost time
	boostTimer.start(boostTime)

