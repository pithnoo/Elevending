extends Node 

# to use in case the effect has a damage property
var damage: int = 0

onready var timer: Timer = $Timer

export(float) var life_time


func _ready():
	timer.start(life_time)

func _process(_delta: float):
	if timer.is_stopped():
		queue_free()
