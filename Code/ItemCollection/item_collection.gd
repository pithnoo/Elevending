class_name Item
extends Node

onready var animations = $AnimationPlayer
onready var states = $StateManager

# input tests
export(String) var item_input
export(String) var turret_input1
export(String) var turret_input2
export(String) var reset_input

var item_control : bool
var turret_control1 : bool
var turret_control2 : bool
var reset_control : bool

# shooting item collection
var shoot_control : bool
var can_shoot : bool = true

# custom turret collection
export(PackedScene) var ground_turret
export(PackedScene) var electric_turret

export(int) var ground_turret_number
export(int) var electric_turret_number

# export file path by string resulted in some quirks, better to manuall reference than use the editor (Godot 3.5)
#export(String, FILE, "*png") var item_crosshair
#export(String, FILE, "*png") var default_crosshair

var is_active : bool = false
var closing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	states.init(self)

func _process(delta):
	shoot_control = Input.is_action_just_pressed("shoot")
	item_control = Input.is_action_just_pressed(item_input)
	reset_control = Input.is_action_just_pressed(reset_input)
	turret_control1 = Input.is_action_just_pressed(turret_input1)
	turret_control2 = Input.is_action_just_pressed(turret_input2)

	if ((turret_control1 || turret_control2 || reset_control) && is_active):

		# to ensure that the animation doesn't play if the same key is pressed twice
		is_active = false
		closing = true

		print("active")

	states.process(delta)

func _physics_process(delta):
	states.physics_process(delta)
