extends Node

export(NodePath) var level_menu_node
onready var level_menu = get_node(level_menu_node)

func _ready():
	AudioManager.play("Soba")
	AudioManager.current_theme = "Soba"

	if GameManager.level_select_first:
		print("checked")
		level_menu.visible = true
		GameManager.level_select_first = false
	else:
		level_menu.visible = false

