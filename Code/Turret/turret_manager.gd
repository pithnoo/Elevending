extends Node

export(float) var cooldown
export(int) var startingTurret
export(Array, PackedScene) var turrets

enum input { t1, t2, t3, t4 }
export(input) var turretInput 

var switchInput

onready var switchTimer = $SwitchTimer
var currentTurret
var activeTurret: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_turret(startingTurret)

func _process(delta):

	match turretInput:
		input.t1:
			switchInput = Input.is_action_just_pressed("turret1")
		input.t2:
			switchInput = Input.is_action_just_pressed("turret2")
		input.t3:
			switchInput = Input.is_action_just_pressed("turret3")
		input.t4:
			switchInput = Input.is_action_just_pressed("turret4")

	if switchInput && switchTimer.is_stopped():

		switchTimer.start(cooldown)

		var wr = weakref(currentTurret)
		if wr.get_ref():
			currentTurret.queue_free()

		activeTurret += 1

		if activeTurret > 2:
			activeTurret = 0
			switch_turret(activeTurret)
		else:
			switch_turret(activeTurret)

func switch_turret(turretIndex: int):
	currentTurret = turrets[turretIndex].instance()
	add_child(currentTurret)
