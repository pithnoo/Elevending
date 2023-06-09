extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Stats_no_health():
	print("game over")
	queue_free()

func _on_HurtBox_area_entered(area:Area2D):
	pass
