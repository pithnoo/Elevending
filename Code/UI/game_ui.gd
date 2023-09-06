extends Control 

var hearts setget set_hearts
var max_hearts setget set_max_hearts
var currency setget set_currency
var num_ground setget set_ground
var num_electric setget set_electric

onready var health_label = $Health
onready var currency_label = $Currency
onready var ground_label = $GroundTurretNumber
onready var electric_label = $ElectricTurretNumber
onready var wave_label1 = $Wave1
onready var wave_label2 = $Wave2

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

func set_ground(value):
	num_ground = value
	
	if ground_label != null:
		ground_label.text = str(num_ground)

func set_electric(value):
	num_electric = value
	
	if electric_label != null:
		electric_label.text = str(num_electric)

func display_wave(value):
	health_label.visible = false
	currency_label.visible = false
	ground_label.visible = false
	electric_label.visible = false

	wave_label1.visible = true
	wave_label2.visible = true

	if wave_label1 != null && wave_label2 != null:
		wave_label1.text = "WAVE " + str(value)
		wave_label2.text = "WAVE " + str(value)

func hide_wave():
	health_label.visible = true
	currency_label.visible = true
	ground_label.visible = true
	electric_label.visible = true

	wave_label1.visible = false
	wave_label2.visible = false

func _ready():
	self.max_hearts = CoreStats.max_health
	self.hearts = CoreStats.health
	self.num_ground = GameManager.ground_turret_number
	self.num_electric = GameManager.electric_turret_number
	
	CoreStats.connect("health_changed", self, "set_hearts")
	GameManager.connect("currency_changed", self, "set_currency")
	GameManager.connect("ground_changed", self, "set_ground")
	GameManager.connect("electric_changed", self, "set_electric")
	GameManager.connect("show_wave", self, "display_wave")
	GameManager.connect("start_wave", self, "hide_wave")
