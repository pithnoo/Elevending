class_name Item
extends Node

onready var shoot_point = $ShootPoint
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
export(PackedScene) var item_to_shoot
export(PackedScene) var muzzle_flash

# custom turret collection
export(PackedScene) var ground_turret
export(PackedScene) var electric_turret

# export file path by string resulted in some quirks, better to manuall reference than use the editor (Godot 3.5)
#export(String, FILE, "*png") var item_crosshair
#export(String, FILE, "*png") var default_crosshair

var item_crosshair = "res://Art/Projectiles/crosshair1.png"
var default_crosshair = "res://Art/Projectiles/crosshair2.png"

var is_active : bool = false
var is_closed : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	states.init(self)
	animations.play("Closed")

func _process(delta):
	states.process(delta)

func _physics_process(delta):
	states.physics_process(delta)

	shoot_control = Input.is_action_just_pressed("shoot")
	item_control = Input.is_action_just_pressed(item_input)
	reset_control = Input.is_action_just_pressed(reset_input)
	turret_control1 = Input.is_action_just_pressed(turret_input1)
	turret_control2 = Input.is_action_just_pressed(turret_input2)

	if item_control && !is_active:
		animations.play("OpenCollect")

		# to ensure that the animation doesn't play if the same key is pressed twice
		is_active = true

		# 40 40 offset to center the designed cursor based on the mouse position
		Input.set_custom_mouse_cursor(load(item_crosshair), Input.CURSOR_ARROW, Vector2(40,40))
	
	if ((turret_control1 || turret_control2 || reset_control) && is_active):
		animations.play("Closed")

		# to ensure that the animation doesn't play if the same key is pressed twice
		is_active = false

		Input.set_custom_mouse_cursor(load(default_crosshair), Input.CURSOR_ARROW, Vector2(40,40))
	
	collect_state()	

func collect_state():
	if shoot_control && can_shoot && is_active:
		animations.play("OpenCollect")
		shoot_item()
		can_shoot = false
	
# for item collection
func shoot_item():
	var projectile = item_to_shoot.instance()
	var effect = muzzle_flash.instance()

	projectile.connect("item_destroyed", self, "reset_shot")
	projectile.connect("item_heal", self, "level_heal")
	projectile.connect("item_ammo", self, "level_ammo")
	projectile.connect("item_shoot", self, "level_shoot")

	var main = get_tree().current_scene

	main.add_child(projectile)
	main.add_child(effect)

	var fire_point = shoot_point.global_position

	projectile.global_position = fire_point
	effect.global_position = fire_point
	
	var mouse_position = get_viewport().get_mouse_position()
	var direction = fire_point.direction_to(mouse_position)
	var projectile_angle = direction.angle()

	projectile.apply_impulse(Vector2.ZERO, Vector2(300, 0).rotated(projectile_angle))

func level_heal():
	print("healed")

func level_ammo():
	print("reloaded turrets")
	GameManager.emit_signal("ammo_reload")

func level_shoot():
	print("increase fire rate")
	GameManager.emit_signal("fire_rate_doubled")

func reset_shot():
	can_shoot = true
