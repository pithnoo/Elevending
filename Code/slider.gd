extends HSlider

# credits to the-shaggy-dev

export(String) var bus_name

var bus_index : int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

	connect("value_changed", self, "_on_value_changed")	

	value = db2linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear2db(value))
