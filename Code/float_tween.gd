extends Node

onready var tween = $Tween

export(NodePath) var target_node
onready var node_to_move : Node2D = get_node(target_node)

export(float) var float_height
export(float) var float_time

func _physics_process(delta):
	var tween_y := node_to_move.create_tween().set_trans(Tween.TRANS_SINE)

	tween_y.tween_property(node_to_move, "global_position:y", float_height, float_time ).as_relative().set_ease(Tween.EASE_OUT)
