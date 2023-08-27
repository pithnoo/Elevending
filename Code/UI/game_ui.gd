extends Control 

var hearts setget set_hearts
var max_hearts setget set_max_hearts

var currency setget set_currency

onready var health_label = $Health
onready var currency_label = $Currency

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)

	if health_label != null:
		health_label.text = str(hearts)

func set_max_hearts(value):
	max_hearts = max(value, 1)

	if health_label != null:
		health_label.text = str(hearts)

func set_currency(value):
	currency = value
	
	if currency_label != null:
		currency_label.text = str(currency)

func _ready():
	self.max_hearts = CoreStats.max_health
	self.hearts = CoreStats.health
	
	CoreStats.connect("health_changed", self, "set_hearts")
	GameManager.connect("currency_changed", self, "set_currency")
