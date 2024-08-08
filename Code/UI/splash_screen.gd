extends Node

export(String, FILE, "*.tscn,*.scn") var next_scene 

export(float) var up_time

onready var splash_timer = $Timer

var splash_played : bool

func _ready():
	splash_played = false
	splash_timer.start(up_time)

	# this is set visible in main_menu.gd
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if splash_timer.is_stopped() && !splash_played:
		splash_played = true
		SceneTransition.fade_transition(next_scene)
