class_name Boss
extends KinematicBody2D

export(NodePath) var dead_node 
onready var dead_state = get_node(dead_node)

onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var boss_timer = $BossTimer
onready var particle_generator = $ParticleGenerator
onready var particle_position = $ParticlePosition

export(NodePath) var ground_enemy_holder_node
onready var ground_enemy_holder = get_node(ground_enemy_holder_node)

# global counter to ensure that the boss doesn't enter it twice
var vending_counter: int
var hard_phase: bool = false
var velocity

func _ready():
	states.init(self)

func _process(delta) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _on_Stats_no_health():
	# TODO: initiate boss battle over (cutscene) transition to dead state
	print("boss beaten")

	# INFO: No matter what, we will always transition to the dead state
	states.change_state(dead_state)
