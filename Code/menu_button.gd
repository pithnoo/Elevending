extends Node

export(Color) var start_colour
export(Color) var reset_colour
export(NodePath) var level_menu_node
export(NodePath) var settings_menu_node

onready var button_text = $Label

onready var level_menu = get_node(level_menu_node)
onready var settings_menu = get_node(settings_menu_node)

var position_modifier : float = 3

func _ready():
	button_text.self_modulate = reset_colour

func shift_start():
	button_text.rect_position.y = button_text.rect_position.y + position_modifier
	button_text.self_modulate = start_colour

func shift_reset():
	button_text.rect_position.y = button_text.rect_position.y - position_modifier
	button_text.self_modulate = reset_colour
	
func _on_PlayButton_pressed():
	AudioManager.play("ButtonPress")
	level_menu.visible = true

func _on_SettingsButton_pressed():
	AudioManager.play("ButtonPress")
	settings_menu.visible = true

func _on_QuitButton_pressed():
	AudioManager.play("ButtonPress")
	get_tree().quit()

func _on_PlayButton_mouse_entered(): shift_start()
func _on_PlayButton_mouse_exited(): shift_reset()

func _on_SettingsButton_mouse_entered(): shift_start()
func _on_SettingsButton_mouse_exited(): shift_reset()

func _on_QuitButton_mouse_entered(): shift_start()
func _on_QuitButton_mouse_exited(): shift_reset()
