extends TurretBaseState 

export(NodePath) var idle_node

onready var idle_state: TurretBaseState = get_node(idle_node)
var nextTimeToFire

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
  if turret.attackRange.entity_detected():
	  if turret.ammo > 0 && turret.rateTimer.is_stopped():
		  turret.rateTimer.start(turret.cooldown)
		  shoot()
	  else:
		  # change to empty state
		  pass
  else:
	  return idle_state

  return null

func shoot():
	# instantiate projectile from scene
  var projectile = turret.Projectile.instance()
  add_child(projectile)
  projectile.global_position = turret.firePoint.global_position
	
  var direction = turret.firePoint.global_position.direction_to(turret.attackRange.entity.global_position)
	
  var projectileAngle = direction.angle()
  projectile.rotation = projectileAngle 
  projectile.apply_impulse(Vector2.ZERO, Vector2(turret.projectileSpeed, 0).rotated(projectileAngle))
