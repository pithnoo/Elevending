extends BaseState

export(PackedScene) var deathEffect


func enter() -> void:
	.enter()
	player.velocity = Vector2.ZERO
