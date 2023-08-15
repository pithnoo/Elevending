extends Node

export(NodePath) var hit_flash

onready var animations = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("Idle")

func _on_AttackHurtBox_area_entered(area:Area2D):
	decrease_health()

func _on_HurtBox_area_entered(area:Area2D):
	decrease_health()
	area.destroy()

func decrease_health() -> void:
	CoreStats.health -= 1

	animations.play("Hurt")
	
	get_node(hit_flash).play("Start")
	
	if CoreStats.health <= 0:
		print("game over")
		queue_free()

func hurt_finished():
	animations.play("Idle")
