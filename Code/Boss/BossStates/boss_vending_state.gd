extends BossBaseState

export(NodePath) var teleport_node
onready var teleport_state = get_node(teleport_node)

export(PackedScene) var boss_vending_machine

export(NodePath) var start_position_node
onready var start_position = get_node(start_position_node).global_position
export(NodePath) var end_position_node
onready var end_position = get_node(end_position_node).global_position

export(float) var easy_pause_time 
export(float) var hard_pause_time
export(float) var move_speed

# TODO: make a smoke partcile 2D to set active
export(NodePath) var smoke_node
onready var smoke_particle = get_node(smoke_node)

func enter():
	.enter()
	if boss.hard_phase:
		boss.boss_timer.start(hard_pause_time)
	else:
		boss.boss_timer.start(easy_pause_time)
	
	# INFO: set boss in starting position to then place hazards
	boss.global_position = start_position

	boss.velocity = Vector2.ZERO

	# to show smoke as the boss is moving
	smoke_particle.visible = true

func physics_process(delta):
	if boss.boss_timer.has_stopped():
		var target = end_position
		var direction = start_position.move_toward(target)
		
		# INFO: same movespeed as the boss projectile
		boss.velocity = boss.velocity.move_toward(direction * 1000, delta * move_speed)		
		boss.velocity = boss.move_and_slide(boss.velocity)
	
	if boss.global_position == end_position:
		return teleport_state

	return null