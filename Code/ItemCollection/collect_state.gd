extends ItemBaseState

export(NodePath) var closed_node
export(NodePath) var ground_node
export(NodePath) var shoot_point
export(PackedScene) var item_to_shoot
export(PackedScene) var muzzle_flash

onready var closed_state = get_node(closed_node)
onready var ground_state = get_node(ground_node)

var item_crosshair = "res://Art/Projectiles/crosshair1.png"

var shoot_control : bool
var can_shoot : bool = true

func enter() -> void:
	.enter()
	Input.set_custom_mouse_cursor(load(item_crosshair), Input.CURSOR_ARROW, Vector2(40,40))

func process(_delta : float) -> ItemBaseState:

	if item.shoot_control && can_shoot && item.is_active:
		can_shoot = false
		shoot_item()
	
	if item.item_control:
		return ground_state

	if item.closing:
		return closed_state

	return null

# for item collection
func shoot_item():
	item.animations.play(animation_name)

	var projectile = item_to_shoot.instance()
	var effect = muzzle_flash.instance()

	projectile.connect("item_destroyed", self, "reset_shot")
	projectile.connect("item_heal", self, "level_heal")
	projectile.connect("item_ammo", self, "level_ammo")
	projectile.connect("item_shoot", self, "level_shoot")

	var main = get_tree().current_scene

	main.add_child(projectile)
	main.add_child(effect)

	var fire_point = get_node(shoot_point).global_position

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
