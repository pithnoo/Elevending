extends BaseState

export(NodePath) var idle_node
export(NodePath) var move_node
export(NodePath) var roll_timer_node
export(NodePath) var motion_timer_node

export(float) var max_roll_speed
export(float) var roll_cooldown
export(float) var motion_time
export(float) var deceleration

onready var idle_state: BaseState = get_node(idle_node)
onready var move_state: BaseState = get_node(move_node)
onready var roll_timer = get_node(roll_timer_node)
onready var motion_timer = get_node(motion_timer_node)

var roll_input = Vector2.ZERO
var roll_direction: Vector2
var is_holding: bool
var roll_finished: bool
var roll_speed: float


func enter() -> void:
	.enter()

	roll_timer.start(roll_cooldown)
	motion_timer.start(motion_time)

	roll_finished = false
	is_holding = true

	roll_speed = max_roll_speed

	# zero input, player rolls in direction they are facing
	roll_direction = Vector2.RIGHT * player.facing_direction


func physics_process(delta: float) -> BaseState:
	if is_holding:
		roll_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		roll_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if roll_input != Vector2.ZERO:
		roll_direction = roll_input.normalized()

	is_holding = false

	if motion_timer.is_stopped():
		roll_speed *= deceleration

	player.velocity = player.move_and_collide(roll_direction * roll_speed * delta)

	if roll_finished:
		return move_state

	return null


func roll_animation_finished():
	roll_finished = true
