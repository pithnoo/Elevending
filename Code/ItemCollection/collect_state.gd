extends ItemBaseState

export(NodePath) var closed_node
export(NodePath) var ground_node

onready var closed_state = get_node(closed_node)
onready var ground_state = get_node(ground_node)

var item_crosshair = "res://Art/Projectiles/crosshair1.png"

var shoot_control : bool

func enter() -> void:
	.enter()
	Input.set_custom_mouse_cursor(load(item_crosshair), Input.CURSOR_ARROW, Vector2(40,40))

func process(delta) -> ItemBaseState:
	shoot_control = Input.is_action_just_pressed("shoot")

	return null
