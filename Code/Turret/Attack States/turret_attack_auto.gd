extends TurretBaseState 

export(NodePath) var idle_node
export(NodePath) var empty_node
export(NodePath) var manual_node
export(NodePath) var turret_range

onready var idle_state: TurretBaseState = get_node(idle_node)
onready var empty_state: TurretBaseState = get_node(empty_node)
onready var manual_state: TurretBaseState = get_node(manual_node)
onready var turret_detect = get_node(turret_range)

export(PackedScene) var Projectile
export(PackedScene) var projectileEffect 

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
	if turret.manualControl == true:
		return manual_state
	if turret.attackRange.entity_detected():
		if turret.ammo > 0 && turret.rateTimer.is_stopped():
			turret.rateTimer.start(turret.cooldown)
			shoot(turret_detect.entities[0])
		elif turret.ammo <= 0:
			return empty_state
	else:
		return idle_state

	return null

func shoot(target):
	AudioManager.play("Shoot")
	if turret.decreaseAmmo:
		turret.ammo -= 1

	# instantiate projectile from scene
	var projectile = Projectile.instance()
	var muzzleFlash = projectileEffect.instance()

	var main = get_tree().current_scene

	main.add_child(projectile)
	add_child(muzzleFlash)

	var shootPoint = turret.firePoint.global_position

	projectile.global_position = shootPoint
	muzzleFlash.global_position = shootPoint

	var direction = shootPoint.direction_to(target.global_position) 

	var projectileAngle = direction.angle()
	projectile.rotation = projectileAngle 
	projectile.apply_impulse(Vector2.ZERO, Vector2(300, 0).rotated(projectileAngle))
