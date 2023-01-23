extends EnemyBaseState

export(NodePath) var follow_core_node
export(NodePath) var follow_player_node

onready var follow_core_state: EnemyBaseState = get_node(follow_core_node)
onready var follow_player_state: EnemyBaseState = get_node(follow_player_node)

func enter() -> void:
  .enter()
  enemy.velocity = Vector2.ZERO

func process(_delta: float) -> EnemyBaseState:
  if enemy.playerDetection.entity_detected():
    return follow_player_state

  return null
