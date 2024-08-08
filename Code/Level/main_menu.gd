extends Node

export(NodePath) var level_menu_node
onready var level_menu = get_node(level_menu_node)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# restricted menu theme will be in boss death state, and core gd
	# this will instead be decided in scene transition gd
	if !GameManager.play_menu_theme:
		GameManager.play_menu_theme = true
	else:
		AudioManager.play("Soba")
		AudioManager.current_theme = "Soba"

	if GameManager.level_select_first:
		level_menu.visible = true
		GameManager.level_select_first = false
	else:
		level_menu.visible = false
