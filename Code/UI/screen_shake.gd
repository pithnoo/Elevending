extends Node

# code from @theshaggydev "how I do screen shake in Godot"

# How quickly to move through the noise
export(float) var noise_shake_speed

# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
export(float) var noise_shake_strength

# The starting range of possible offsets using random values
export(float) var random_shake_strength

# Multiplier for lerping the shake strength to zero
export(float) var shake_decay_rate

var shake_strength: float = 0.0

export(NodePath) var camera_node
onready var camera = get_node(camera_node)

onready var rand = RandomNumberGenerator.new()
onready var noise = OpenSimplexNoise.new()

# to keep track of where we currently are in the noise
var noise_i: float = 0.0

func _ready():
	rand.randomize()

	# randomize generated noise
	noise.seed = rand.randi()

	# period effecs how quickly noise changes values
	noise.period = 2


func _process(delta):
	shake_strength = lerp(shake_strength, 0, shake_decay_rate * delta)
	camera.offset = get_random_offset()


func apply_shake() -> void:
	shake_strength = random_shake_strength
	#camera.offset = get_random_offset()


func get_noise_offset(delta) -> Vector2:
	noise_i += delta * noise_shake_speed

	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)


func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
