extends Node

export(PackedScene) var Projectile
export(PackedScene) var projectileEffect

export(NodePath) var shooter

func shoot(target) -> void:
	var projectile = Projectile.instance()

	var main = get_tree().current_scene

	main.add_child(projectile)
