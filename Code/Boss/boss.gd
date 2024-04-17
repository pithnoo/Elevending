class_name Boss
extends KinematicBody2D 

onready var animations = $AnimationPlayer
onready var states = $StateManager

onready var particleGenerator = $ParticleGenerator
onready var particlePosition = $ParticlePosition

func _ready():
	states.init(self)

func _process(delta) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _on_Stats_no_health():
	# TODO: initiate boss battle over (cutscene)
	pass
