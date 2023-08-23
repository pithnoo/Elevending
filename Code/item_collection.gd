extends Node

var shoot_control : bool
var can_shoot : bool = true

export(String) var item_input
var item_control : bool

export(String) var turret_input1
var turret_control1 : bool

export(String) var turret_input2
var turret_control2 : bool

export(String) var reset_input
var reset_control : bool

export(PackedScene) var item_to_shoot
export(PackedScene) var muzzle_flash

onready var shoot_point = $ShootPoint

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

func _physics_process(delta):
	shoot_control = Input.is_action_just_pressed("shoot")
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

	if shoot_control && is_active && can_shoot:
		animations.play("Open")
		shoot_item()
		can_shoot = false

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
