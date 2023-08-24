extends ItemBaseState
class_name ItemTurretState

export(NodePath) var close_node
onready var close_state = get_node(close_node)

export(NodePath) var collect_node
onready var collect_state = get_node(collect_node)

export(PackedScene) var turret_to_place
export(PackedScene) var muzzle_flash
export(NodePath) var shoot_point

export(NodePath) var timer_node
onready var place_timer = get_node(timer_node)

export(float) var place_time

func set_cursor(turret_cursor):
	Input.set_custom_mouse_cursor(turret_cursor)

func place_turret():
	item.animations.play(animation_name)

	var effect = muzzle_flash.instance()
	var fire_point = get_node(shoot_point).global_position

	var turret = turret_to_place.instance()
	var main = get_tree().current_scene

	main.add_child(turret)
	main.add_child(effect)

	var turret_position = get_viewport().get_mouse_position()

	turret.global_position = turret_position
	effect.global_position = fire_point
