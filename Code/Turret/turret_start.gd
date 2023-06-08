extends TurretBaseState

export(NodePath) var idle_node

onready var idle_state: TurretBaseState = get_node(idle_node)
var animation_finished = false

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
	if animation_finished:
		return idle_state
	
	return null

func _on_AnimationPlayer_animation_finished(anim_name:String):
	animation_finished = true
