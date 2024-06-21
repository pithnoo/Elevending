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

export(Array, NodePath) var vending_positions

export(PackedScene) var boss_shadow

func enter():
	.enter()
	boss.vending_remains = true

	if boss.boss_phase >= 2:
		boss.boss_timer.start(hard_pause_time)
	else:
		boss.boss_timer.start(easy_pause_time)

	boss.global_position = start_position

	for vending_position in vending_positions:
		var position = get_node(vending_position)
		position.connect("easy_position", self, "spawn")
		position.connect("hard_position", self, "spawn_hard")

	boss.velocity = Vector2.ZERO

func physics_process(delta):
	if boss.boss_timer.is_stopped():
		var target = end_position
		var direction = boss.global_position.direction_to(target)

		boss.velocity = boss.velocity.move_toward(direction * 1000, delta * move_speed)
		boss.velocity = boss.move_and_slide(boss.velocity)

		# INFO: this is the trail behind the boss
		if boss.shadow_timer.is_stopped():
			boss.shadow_timer.start(0.10)
			var entity = boss_shadow.instance()
			entity.global_position = boss.global_position
			boss.ground_enemy_holder.add_child(entity)	

		if boss.global_position.distance_to(end_position) < 5:
			boss.velocity = Vector2.ZERO
			return teleport_state

	return null

func spawn():
	var entity = boss_vending_machine.instance()

	entity.global_position = boss.global_position
	boss.ground_enemy_holder.add_child(entity)

	entity.connect("turret_destroyed", boss, "vending_destroyed")

	boss.vending_counter += 1

	if boss.boss_phase >= 2:
		entity.stats.set_health(1)

func spawn_hard():
	if boss.boss_phase >= 3:
		spawn()
