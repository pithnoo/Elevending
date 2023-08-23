extends ItemBaseState

export(NodePath) var collect_node
onready var collect_state = get_node(collect_node)

var default_crosshair = "res://Art/Projectiles/crosshair2.png"

func enter() -> void:
	.enter()
	item.closing = false

	# 40 40 offset to center the designed cursor based on the mouse position
	Input.set_custom_mouse_cursor(load(default_crosshair), Input.CURSOR_ARROW, Vector2(40,40))

func process(_delta : float) -> ItemBaseState:

	if item.item_control && !item.is_active:

		# to ensure that the animation doesn't play if the same key is pressed twice
		item.is_active = true
		return collect_state

	return null
