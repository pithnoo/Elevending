extends Node2D

# provide particle to spawn
# position (position 2D) to spawn the particle
func generate_particle(particle_to_spawn, particle_position) -> void:
	var particle = particle_to_spawn.instance()
	
	var main = get_tree().current_scene
	main.add_child(particle)

	particle.global_position = particle_position.global_position

func generate_temp_particle(particle_to_spawn, particle_position, particle_lifetime) -> void:
	var particle = particle_to_spawn.instance()
	particle.life_time = particle_lifetime

	add_child(particle)

	particle.global_position = particle_position.global_position
