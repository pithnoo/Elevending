extends EnemyBaseState

export(NodePath) var follow_core_node
export(NodePath) var follow_player_node
export(NodePath) var player_range
export(NodePath) var core_range

onready var player_detect = get_node(player_range)
onready var core_detect = get_node(core_range)

onready var follow_core_state: EnemyBaseState = get_node(follow_core_node)
onready var follow_player_state: EnemyBaseState = get_node(follow_player_node)

enum idle_mode { FOLLOW_CORE_ONLY, FOLLOW_PLAYER_CORE }
export(idle_mode) var mode

func enter() -> void:
  .enter()
  enemy.velocity = Vector2.ZERO

func process(_delta: float) -> EnemyBaseState:
  match mode:
    idle_mode.FOLLOW_CORE_ONLY:
      if core_detect.entity_detected():
        return follow_core_state
    idle_mode.FOLLOW_PLAYER_CORE:
      if player_detect.entity_detected():
        return follow_player_state
      elif core_detect.entity_detected():
        return follow_core_state
  return null
