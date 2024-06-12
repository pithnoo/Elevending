extends TurretBaseState

export(PackedScene) var finish_particle

export(NodePath) var emission_position
onready var emission = get_node(emission_position)


func enter() -> void:
	.enter()
	AudioManager.play("TurretPlace")


func turret_slam():
	AudioManager.play("TurretSlam")


func attack_finished():
	AudioManager.play("TurretUsed")
	var particle = finish_particle.instance()
	var main = get_tree().current_scene

	particle.global_position = emission.global_position

	main.add_child(particle)

	turret.queue_free()
