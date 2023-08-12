extends EnemyBaseState 

export(NodePath) var follow_node
onready var follow_state: EnemyBaseState = get_node(follow_node)

export(NodePath) var stun_timer
onready var timer = get_node(stun_timer)

export(PackedScene) var stun_particle
export(int) var stun_time

var particle

func enter() -> void:
	.enter()
	enemy.velocity = Vector2.ZERO

	particle = stun_particle.instance()
	enemy.add_child(particle)

	timer.start(stun_time)

func process(_delta: float) -> EnemyBaseState:
	if timer.is_stopped():
		enemy.is_stunned = false

		particle.queue_free()
		return follow_state

	return null
