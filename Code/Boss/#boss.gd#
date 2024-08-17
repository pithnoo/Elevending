class_name Boss
extends KinematicBody2D

export(NodePath) var dead_node 
onready var dead_state = get_node(dead_node)

onready var animations = $AnimationPlayer
onready var states = $StateManager
onready var boss_timer = $BossTimer
onready var shadow_timer = $ShadowTimer
onready var particle_generator = $ParticleGenerator
onready var particle_position = $ParticlePosition

export(NodePath) var ground_enemy_holder_node
onready var ground_enemy_holder = get_node(ground_enemy_holder_node)

export(NodePath) var hurt_box_node
onready var hurt_box = get_node(hurt_box_node)

export(NodePath) var health_bar_node
onready var health_bar = get_node(health_bar_node)

# INFO: global counter to ensure that the boss doesn't enter it twice
var vending_counter : int
var vending_remains : bool = false
var hard_phase: bool = false
var can_items_spawn : bool = false
var boss_items_spawn : bool = false

# preventing the boss from using the vending attack twice in a row
var vending_before : bool = false
var velocity

export(int) var damage_threshold
var damage_counter : int = 0
var boss_health : int = 0
var boss_phase : int

var boss_beaten : bool = false

signal enough_damage

func _ready():
  states.init(self)
  hurt_box.invincible = true
  boss_phase = 0
  hard_phase = false
  can_items_spawn = false
  boss_items_spawn = false

func _process(delta) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _on_Stats_max_health_changed(health):
	boss_health = health 

func _on_Stats_health_changed(health):

	damage_counter += 1

	if damage_counter > damage_threshold:
		emit_signal("enough_damage")
			
	match boss_phase:
		0:
			if health <= round(boss_health * 0.75):
				boss_items_spawn = true
				boss_phase += 1
				get_node(health_bar_node).set_frame(1)
		1:
			if health <= round(boss_health / 2):
				hard_phase = true  
				boss_phase += 1
				get_node(health_bar_node).set_frame(2)
		2:
			if health <= round(boss_health / 4):
				boss_phase += 1
				get_node(health_bar_node).set_frame(3)
		3:
			if health == 0:
				get_node(health_bar_node).set_frame(4)
				boss_items_spawn = false
	
func _on_Stats_no_health():
  if !boss_beaten:
	  boss_beaten = true
	  states.change_state(dead_state)

func vending_destroyed():
	vending_counter -= 1
	if vending_counter <= 0:
		vending_remains = false
