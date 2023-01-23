extends EnemyBaseState

export(NodePath) var follow_player_node
export(NodePath) var idle_node

onready var follow_player_state: EnemyBaseState = get_node(follow_player_node)
onready var idle_state: EnemyBaseState = get_node(idle_node)

func enter() -> void:
  .enter()

func physics_process(_delta: float) -> EnemyBaseState:
  if enemy.playerDetection.entity_detected():
    return follow_player_state
  else:
    # follow core
    pass
  return null
