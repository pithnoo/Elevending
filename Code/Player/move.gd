extends BaseState 

export(NodePath) var idle_node
export(float) var move_speed

onready var idle_state: BaseState = get_node(idle_node)

var move_input = Vector2.ZERO

func enter() -> void:
	.enter()

func physics_process(delta: float) -> BaseState:
	move_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if move_input < Vector2.ZERO:
		player.sprite.flip_h = true
	elif move_input > Vector2.ZERO:
		player.sprite.flip_h = false

	if move_input == Vector2.ZERO:
		return idle_state
	
	player.velocity = move_input.normalized() * move_speed * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	return null
