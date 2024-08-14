extends Control

export(String, FILE, "*.tscn,*.scn") var menu

var notes: int

export(int) var max_notes = 3
export(float) var time_till_display

export(NodePath) var notes_UI_empty_node
export(NodePath) var notes_UI_full_node

onready var notesUIFull = get_node(notes_UI_full_node)
onready var notesUIEmpty = get_node(notes_UI_empty_node)

onready var animations = $AnimationPlayer
onready var timer = $Timer

func set_notes(value):
	if !GameManager.game_over:
		GameManager.can_pause = false

		timer.start()
		yield(timer, "timeout")

		get_tree().paused = true

		GameManager.change_game_cursor(0)

		visible = true

		animations.play("Complete")
		notes = clamp(value, 0, max_notes)

		if notesUIFull != null:
			# 28 is the pixel size of the note sprite
			notesUIFull.rect_size.x = notes * 28

func _ready():
	visible = false

	if notesUIEmpty != null:
		# 28 is the pixel size of the empty note sprite
		notesUIEmpty.rect_size.x = max_notes * 28

	GameManager.connect("display_rating", self, "set_notes")

func _on_NextButton_pressed():
	# stopping in case of song switch
	AudioManager.stop_playing(AudioManager.current_theme)

	LevelManager.emit_signal("next_level")

func _on_MenuButton_pressed():
	SceneTransition.blind_transition(menu)
	GameManager.level_select_first = true
