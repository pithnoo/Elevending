extends BaseState

export(NodePath) var move_node

onready var move_state: BaseState = get_node(move_node)

var move_input = Vector2.ZERO

func enter() -> void:
	.enter()
	player.velocity = Vector2.ZERO 

func physics_process(_delta: float) -> BaseState:
	move_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if move_input != Vector2.ZERO:
		return move_state

	return null	
