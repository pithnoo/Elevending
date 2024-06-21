extends Control

var buttons: Array

var unlock_buffer: int = 0
onready var ratings_size = LevelManager.level_ratings.size()

func _ready():
	for button in get_children():
		buttons.append(button)

	for i in buttons.size():
		buttons[i].set_rating(0)

		# check if locked / unlocked
		if i + 1 > LevelManager.levels_unlocked:
			buttons[i].disabled = true
		else:
			buttons[i].disabled = false

			if ratings_size > 0:
				unlock_buffer += 1

				if unlock_buffer <= ratings_size:
					buttons[i].set_rating(LevelManager.level_ratings[i])
