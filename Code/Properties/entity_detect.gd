extends Area2D

var entities: Array 

func entity_detected():
  if entities.size() > 0:
    return true
  else:
    return false

func _on_AttackRange_body_exited(body:Node):
  remove_body(body)

func _on_AttackRange_body_entered(body:Node):
  add_body(body)

func _on_CoreRange_body_exited(body:Node):
  remove_body(body)

func _on_CoreRange_body_entered(body:Node):
  add_body(body)

func add_body(body):
  entities.append(body)

func remove_body(body):
  entities.erase(body)
