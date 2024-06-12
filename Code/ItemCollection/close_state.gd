extends ItemBaseState

export(NodePath) var collect_node
onready var collect_state = get_node(collect_node)


func enter() -> void:
	.enter()
	item.closing = false


func process(_delta: float) -> ItemBaseState:
	set_cursor()

	if item.item_control && !item.is_active:
		# to ensure that the animation doesn't play if the same key is pressed twice
		item.is_active = true
		return collect_state

	return null


func set_cursor():
	if GameManager.is_manual:
		GameManager.change_game_cursor(1)
	else:
		GameManager.change_game_cursor(0)
