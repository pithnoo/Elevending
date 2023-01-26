extends EnemyFollowState 

enum follow_mode { FOLLOW_CORE_ONLY, FOLLOW_PLAYER_CORE }
export(follow_mode) var mode

export(NodePath) var follow_player_node
export(NodePath) var idle_node

onready var follow_player_state: EnemyFollowState = get_node(follow_player_node)
onready var idle_state: EnemyBaseState = get_node(idle_node)

func enter() -> void:
  .enter()

func physics_process(delta: float) -> EnemyBaseState:
  match mode:
    follow_mode.FOLLOW_CORE_ONLY:
      if core_detect.entity_detected():
        follow_entity(core_detect, delta)
      else:
        return idle_state
    follow_mode.FOLLOW_PLAYER_CORE:
      if player_detect.entity_detected():
        return follow_player_state
      elif core_detect.entity_detected():
        follow_entity(core_detect, delta)
      else:
        return idle_state
  return null
