extends Node

export(NodePath) var starting_state

var current_state: BossBaseState

func change_state(new_state: BossBaseState) -> void:
  if current_state:
	  current_state.exit()

  current_state = new_state
  current_state.enter()

func init(boss: Boss) -> void:
  for child in get_children():
	  child.boss = boss

  change_state(get_node(starting_state))

func physics_process(delta: float) -> void:
  var new_state = current_state.physics_process(delta)

  if new_state:
	  change_state(new_state)

func process(delta: float) -> void:
  var new_state = current_state.process(delta)

  if new_state:
	  change_state(new_state)
