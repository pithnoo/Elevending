extends BossBaseState

export(NodePath) var idle_node
onready var idle_state = get_node(idle_node)

export(NodePath) var idle_position_node
onready var idle_position = get_node(idle_position_node).global_position

export(PackedScene) var warp_particle

func enter():
  .enter()
  boss.global_position = idle_position
  AudioManager.play("BossWarp")
  
func process(delta):
  var particle = warp_particle.instance()
  particle.global_position = boss.global_position
  add_child(particle)

  return idle_state
