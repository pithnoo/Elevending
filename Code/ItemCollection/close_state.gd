extends ItemBaseState

export(NodePath) var collect_node
onready var collect_state = get_node(collect_node)

var default_crosshair = "res://Art/Projectiles/crosshair3.png"
var manual_crosshair = "res://Art/Projectiles/crosshair2.png"

func enter() -> void:
	.enter()
	item.closing = false

func process(_delta : float) -> ItemBaseState:
	set_cursor()

	if item.item_control && !item.is_active:

		# to ensure that the animation doesn't play if the same key is pressed twice
		item.is_active = true
		return collect_state

	return null

func set_cursor():
	if GameManager.is_manual:
			Input.set_custom_mouse_cursor(load(manual_crosshair), Input.CURSOR_ARROW, Vector2(40,40))
	else:
			# 40 40 offset to center the designed cursor based on the mouse position
			Input.set_custom_mouse_cursor(load(default_crosshair), Input.CURSOR_ARROW, Vector2(40,40))


