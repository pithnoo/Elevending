extends Node

signal easy_position
signal hard_position

enum difficulty_type { EASY, HARD }
export(difficulty_type) var difficulty

func _on_Area2D_area_entered(area: Area2D):
	match difficulty:
		difficulty_type.EASY:
			emit_signal("easy_position")
		difficulty_type.HARD:
			emit_signal("hard_position")
		_:
			print("unknown position difficulty, please check")
