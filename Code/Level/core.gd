extends Node

export(NodePath) var hit_flash

onready var animations = $AnimationPlayer

# if the enemy area collides with the core
# the core can pass this value
var knockback_vector = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("Idle")

func _on_AttackHurtBox_area_entered(area:Area2D):
	#print("core recorded: ", area.damage, " damage from ", area)

	decrease_health(area.damage)

func _on_HurtBox_area_entered(area:Area2D):
	#print("core recorded: ", area.damage, " damage from ", area)

	decrease_health(area.damage)
	area.destroy()

func decrease_health(damage_taken : int) -> void:
	CoreStats.health -= damage_taken

	animations.play("Hurt")
	
	get_node(hit_flash).play("Start")
	
	if CoreStats.health <= 0:
		print("game over")
		queue_free()

func hurt_finished():
	animations.play("Idle")
