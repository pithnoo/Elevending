extends Node

export(NodePath) var hit_flash

onready var animations = $AnimationPlayer
onready var core_position = $CorePosition

export(String, FILE, "*.tscn,*.scn") var menu

export(NodePath) var core_detection_node
onready var core_detection = get_node(core_detection_node)

# if the enemy area collides with the core
# the core can pass this value
var knockback_vector = Vector2.DOWN


# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("Idle")
	GameManager.core_position = core_position
	GameManager.game_over = false


func _on_AttackHurtBox_area_entered(area: Area2D):
	#print("core recorded: ", area.damage, " damage from ", area)

	decrease_health(area.damage)


func _on_HurtBox_area_entered(area: Area2D):
	#print("core recorded: ", area.damage, " damage from ", area)

	decrease_health(area.damage)
	area.destroy()


func decrease_health(damage_taken: int) -> void:
	if !GameManager.game_over:
		CoreStats.health -= damage_taken
		animations.play("Hurt")
		get_node(hit_flash).play("Start")

	if CoreStats.health <= 0:
		if !GameManager.game_over:
			AudioManager.play("CoreDown")

			core_detection.queue_free()

			GameManager.can_pause = false

			# so that the game over event doesn't trigger multiple times
			# when core is damaged
			GameManager.game_over = true

			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

			GameManager.emit_signal("game_over")

			animations.play("GameOver")
			yield(animations, "animation_finished")

			SceneTransition.over_transition(menu)


func hurt_finished():
	animations.play("Idle")
