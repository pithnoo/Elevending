extends Area2D

var entity: Node = null

func entity_detected():
	return entity != null

func _on_AttackRange_body_exited(_body:Node):
	entity = null
	pass

func _on_AttackRange_body_entered(body:Node):
  entity = body
  pass

func _on_CoreRange_body_exited(_body:Node):
  entity = null
  pass 

func _on_CoreRange_body_entered(body:Node):
  entity = body
  pass
