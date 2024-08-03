extends Timer

export(float) var life_time

# Called when the node enters the scene tree for the first time.
func _ready():
	start(life_time)

func _process(delta):
	if is_stopped():
		get_parent().queue_free()

func _physics_process(delta):
	while is_stopped():
		pass
