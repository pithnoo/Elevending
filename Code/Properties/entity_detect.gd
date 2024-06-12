extends Area2D

var entities: Array

var turret_distance


func entity_detected():
	if entities.size() > 0:
		return true
	else:
		return false


func _on_AttackRange_body_exited(body: Node):
	remove_body(body)


func _on_AttackRange_body_entered(body: Node):
	add_body(body)


func _on_CoreRange_body_exited(body: Node):
	remove_body(body)


func _on_CoreRange_body_entered(body: Node):
	add_body(body)


func add_body(body):
	entities.append(body)


func remove_body(body):
	entities.erase(body)


# ensures that the turret always locks onto the closest target
# rather than the target which it was aiming for before
func find_closest_target():
	var closest_target = null
	var closest_target_distance = 0
	var current_target_distance = 0

	for entity in entities:
		current_target_distance = self.global_position.distance_to(entity.global_position)

		if closest_target == null || current_target_distance < closest_target_distance:
			closest_target = entity
			closest_target_distance = current_target_distance

	return closest_target
