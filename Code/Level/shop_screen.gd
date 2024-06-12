extends Node

onready var animations = $AnimationPlayer

export(NodePath) var wave_spawner_node
onready var wave_spawner = get_node(wave_spawner_node)

export(String) var starting_animation
export(String) var idle_animation


# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play(starting_animation)

	GameManager.connect("show_wave", self, "next_wave")
	GameManager.connect("start_wave", self, "show_ui")


func next_wave(value):
	animations.play(idle_animation)


func show_ui():
	animations.play(starting_animation)


func _process(delta):
	pass
