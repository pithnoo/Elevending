extends Timer

export(float) var life_time


# Called when the node enters the scene tree for the first time.
func _ready():
	start(life_time)


func _process(delta):
	if is_stopped():
		get_parent().queue_free()
