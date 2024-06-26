class_name Item
extends Node

onready var animations = $AnimationPlayer
onready var states = $StateManager

export(NodePath) var turret_holder_node
onready var turret_holder = get_node(turret_holder_node)

# input tests
export(String) var item_input
export(String) var turret_input1
export(String) var turret_input2
export(String) var reset_input

var item_control: bool
var turret_control1: bool
var turret_control2: bool
var reset_control: bool
var shoot_control: bool

# export file path by string resulted in some quirks, better to manuall reference than use the editor (Godot 3.5)
#export(String, FILE, "*png") var item_crosshair
#export(String, FILE, "*png") var default_crosshair

var is_active: bool = false
var closing: bool = false
var can_place: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	states.init(self)


func _process(delta):
	shoot_control = Input.is_action_just_pressed("shoot")
	item_control = Input.is_action_just_pressed(item_input)
	reset_control = Input.is_action_just_pressed(reset_input)
	turret_control1 = Input.is_action_just_pressed(turret_input1)
	turret_control2 = Input.is_action_just_pressed(turret_input2)

	if (turret_control1 || turret_control2 || reset_control) && is_active:
		# to ensure that the animation doesn't play if the same key is pressed twice
		is_active = false
		closing = true

	states.process(delta)


func _physics_process(delta):
	states.physics_process(delta)


func _on_NoTurret_mouse_exited():
	can_place = true


func _on_NoTurret_mouse_entered():
	can_place = false
