extends TurretBaseState 

export(NodePath) var idle_node
export(NodePath) var empty_node

onready var idle_state: TurretBaseState = get_node(idle_node)
onready var empty_state: TurretBaseState = get_node(empty_node)

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
  if turret.attackRange.entity_detected():
    if turret.ammo > 0 && turret.rateTimer.is_stopped():
      turret.rateTimer.start(turret.cooldown)
      shoot()
    elif turret.ammo <= 0:
      return empty_state
  else:
    return idle_state

  return null

func shoot():
  turret.ammo -= 1
	# instantiate projectile from scene
  var projectile = turret.Projectile.instance()
  add_child(projectile)
  projectile.global_position = turret.firePoint.global_position
	
  var direction = turret.firePoint.global_position.direction_to(turret.attackRange.entity.global_position)
	
  var projectileAngle = direction.angle()
  projectile.rotation = projectileAngle 
  projectile.apply_impulse(Vector2.ZERO, Vector2(200, 0).rotated(projectileAngle))
