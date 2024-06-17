extends BossBaseState

export(float) var hard_cooldown
export(float) var easy_cooldown

export(NodePath) var idle_node
onready var idle_state = get_node(idle_node)

export(NodePath) var smoke_particle_node
onready var smoke_particle = get_node(smoke_particle_node)

export(PackedScene) var warp_particle

var taken_damage : bool

func enter():
	.enter()
	var particle = warp_particle.instance()
	particle.global_position = boss.global_position
	add_child(particle)

	taken_damage = false

	smoke_particle.visible = true
	if boss.hard_phase:
		boss.boss_timer.start(hard_cooldown)
	else:
		boss.boss_timer.start(easy_cooldown)

	boss.hurt_box.invincible = false

func process(delta):
	if boss.boss_timer.is_stopped() || taken_damage:
		smoke_particle.visible = false
		var particle = warp_particle.instance()
		particle.global_position = boss.global_position
		add_child(particle)

		boss.hurt_box.invincible = true
		boss.damage_counter = 0

		return idle_state

	return null

func _on_Boss_enough_damage():
	taken_damage = true
