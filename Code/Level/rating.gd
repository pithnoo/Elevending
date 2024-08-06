extends TextureButton

export(String, FILE, "*.tscn,*.scn") var level_buffer

var rating: int = 0

export(int) var max_notes = 3
var notes: int

onready var notesUIFull = $Notes
onready var notesUIEmpty = $NotesEmpty

func set_rating(value):
	notes = clamp(value, 0, max_notes)

	if notesUIFull != null:
		# 7 is the pixel size of the note sprite
		notesUIFull.rect_size.x = notes * 7

# Called when the node enters the scene tree for the first time.
func _ready():
	if notesUIEmpty != null:
		# 7 is the pixel size of the empty note sprite
		notesUIEmpty.rect_size.x = max_notes * 7

func _process(_delta: float):
	if is_pressed():
		AudioManager.stop_playing("Soba")
		SceneTransition.blind_transition(level_buffer)
		GameManager.reset_game_values()
