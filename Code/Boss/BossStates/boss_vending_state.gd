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

export(NodePath) var smoke_node
onready var smoke_particle = get_node(smoke_node)

export(Array, NodePath) var vending_positions

func enter():
	.enter()
	#boss.visible = false
	boss.vending_remains = true

	if boss.hard_phase:
		boss.boss_timer.start(hard_pause_time)
	else:
		boss.boss_timer.start(easy_pause_time)

	boss.global_position = start_position

	for vending_position in vending_positions:
		var position = get_node(vending_position)
		position.connect("easy_position", self, "spawn")
		position.connect("hard_position", self, "spawn_hard")

	boss.velocity = Vector2.ZERO

	# to show smoke as the boss is moving
	smoke_particle.visible = true

func physics_process(delta):
	if boss.boss_timer.is_stopped():
		var target = end_position
		var direction = boss.global_position.direction_to(target)

		# INFO: same movespeed as the boss projectile
		boss.velocity = boss.velocity.move_toward(direction * 1000, delta * move_speed)
		boss.velocity = boss.move_and_slide(boss.velocity)

		if boss.global_position.distance_to(end_position) < 5:
			boss.velocity = Vector2.ZERO
			smoke_particle.visible = false
			return teleport_state

	return null

func spawn():
	# INFO: particle generator will auto fetch boss global position so should be fine
		
	var entity = boss_vending_machine.instance()

	entity.global_position = boss.global_position
	boss.ground_enemy_holder.add_child(entity)

	# TODO: check if decreasing the turret counter in parent works
	entity.connect("turret_destroyed", boss, "vending_destroyed")

	boss.vending_counter += 1

func spawn_hard():
	if boss.hard_phase:
		spawn()
