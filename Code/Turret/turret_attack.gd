extends TurretBaseState 

export(NodePath) var idle_node

onready var idle_state: TurretBaseState = get_node(idle_node)
var nextTimeToFire

func enter() -> void:
	.enter()

func process(_delta: float) -> TurretBaseState:
  if turret.attackRange.entity_detected():
	  if turret.ammo > 0 && turret.rateTimer.is_stopped():
		  print("fired")
		  shoot()
	  else:
		  # change to no empty state
		  pass
  else:
	  return idle_state

  return null

func shoot():
  turret.rateTimer.start(turret.cooldown)

	# instantiate projectile from scene
  var projectile = turret.Projectile.instance()
  add_child(projectile)
	
  var direction = (turret.AttackRange.entity.position - turret.global_position).normalized()
	
  projectile.rotation = direction.angle()
  projectile.velocity = direction * turret.projectileSpeed 
