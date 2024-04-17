class_name Boss
extends KinematicBody2D 

onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var boss_timer = $BossTimer
onready var particle_generator = $ParticleGenerator
onready var particle_position = $ParticlePosition

# global counter to ensure that the boss doesn't enter it twice
var vending_counter : int
var hard_phase : bool = false
var velocity

func _ready():
	states.init(self)

func _process(delta) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _on_Stats_no_health():
	# TODO: initiate boss battle over (cutscene) transition to dead state
	pass
