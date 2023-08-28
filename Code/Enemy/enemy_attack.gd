extends EnemyBaseState

export(NodePath) var idle_node
onready var idle_state: EnemyBaseState = get_node(idle_node)

export(NodePath) var charge_timer_node
onready var charge_timer = get_node(charge_timer_node)

export(NodePath) var particle_generator_node
onready var particle_generator = get_node(particle_generator_node)

export(NodePath) var core_range
onready var core_detect = get_node(core_range)

# note enemy particle position in parent
export(PackedScene) var enemy_attack
export(PackedScene) var enemy_charge
export(PackedScene) var charge_effect
export(int) var charge_time

export(float) var repulsion_speed

var attack_finished : bool

func enter() -> void:
	.enter()
	attack_finished = false

	enemy.velocity = Vector2.ZERO
	particle_generator.generate_particle(enemy_charge, enemy.particlePosition)

	particle_generator.generate_temp_particle(charge_effect, enemy.particlePosition, charge_time)

	charge_timer.start(charge_time)

func physics_process(delta: float) -> EnemyBaseState:
	if charge_timer.is_stopped():
		attack()
		return idle_state

	return null

func attack():
	var target
	if core_detect.entities.size() > 0: 
		target = core_detect.entities[0].global_position
	else:
		target = Vector2.UP

	var direction = enemy.global_position.direction_to(target) * -1

	var attack_effect = enemy_attack.instance()

	attack_effect.damage = enemy.enemyDamage
	
	var main = get_tree().current_scene
	main.add_child(attack_effect)

	attack_effect.global_position = enemy.particlePosition.global_position	

	enemy.knockback = direction.normalized() * repulsion_speed
