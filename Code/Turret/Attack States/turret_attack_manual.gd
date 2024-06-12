extends TurretBaseState

export(NodePath) var empty_node
export(NodePath) var start_node
export(NodePath) var manual_effect

onready var empty_state: TurretBaseState = get_node(empty_node)
onready var start_state: TurretBaseState = get_node(start_node)

var shootInput: bool

export(PackedScene) var Projectile
export(PackedScene) var projectileEffect


func enter() -> void:
	.enter()
	get_node(manual_effect).visible = true
	AudioManager.play("TurretPlace")


func process(delta: float) -> TurretBaseState:
	if Input.is_action_just_pressed("shoot"):
		shootInput = true
	if Input.is_action_just_released("shoot"):
		shootInput = false

	if turret.manualControl == false || turret.ammo <= 0:
		shootInput = false
		get_node(manual_effect).visible = false
		return start_state

	elif turret.ammo > 0 && turret.rateTimer.is_stopped() && shootInput:
		turret.rateTimer.start(turret.cooldown)
		var mouse_position = get_viewport().get_mouse_position()
		shoot(mouse_position)

	return null


func shoot(target):
	AudioManager.play("ManualShoot")
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

	var direction = shootPoint.direction_to(target)

	var projectileAngle = direction.angle()
	projectile.rotation = projectileAngle
	projectile.apply_impulse(Vector2.ZERO, Vector2(300, 0).rotated(projectileAngle))
