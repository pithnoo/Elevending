extends Node

onready var master_slider = $MasterSlider
onready var sfx_slider = $SfxSlider
onready var music_slider = $MusicSlider


func _on_MasterSlider_mouse_exited():
	master_slider.release_focus()


func _on_SfxSlider_mouse_exited():
	sfx_slider.release_focus()


func _on_MusicSlider_mouse_exited():
	music_slider.release_focus()
