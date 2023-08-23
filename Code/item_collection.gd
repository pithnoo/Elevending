extends Node

export(String) var item_input
var item_control : bool

export(String) var turret_input1
var turret_control1 : bool

export(String) var turret_input2
var turret_control2 : bool

export(String) var reset_input
var reset_control : bool

# export file path by string resulted in some quirks, better to manuall reference than use the editor (Godot 3.5)
#export(String, FILE, "*png") var item_crosshair
#export(String, FILE, "*png") var default_crosshair

var item_crosshair = "res://Art/Projectiles/crosshair1.png"
var default_crosshair = "res://Art/Projectiles/crosshair2.png"

onready var animations = $AnimationPlayer

var is_active : bool = false
var is_closed : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("Closed")

func _process(delta):
	item_control = Input.is_action_just_pressed(item_input)
	reset_control = Input.is_action_just_pressed(reset_input)
	turret_control1 = Input.is_action_just_pressed(turret_input1)
	turret_control2 = Input.is_action_just_pressed(turret_input2)

	if item_control && !is_active:
		animations.play("Open")

		# to ensure that the animation doesn't play if the same key is pressed twice
		is_active = true

		Input.set_custom_mouse_cursor(load(item_crosshair))
	
	if ((turret_control1 || turret_control2 || reset_control) && is_active):
		animations.play("Closed")

		# to ensure that the animation doesn't play if the same key is pressed twice
		is_active = false

		Input.set_custom_mouse_cursor(load(default_crosshair))
