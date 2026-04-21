extends Area2D

@export var SceneBefore: GM.Scenes
var canClick: bool = false

func _ready() -> void:
	mouse_entered.connect(_hovered.bind(true))
	mouse_exited.connect(_hovered.bind(false))

func _process(_delta: float) -> void:
	if (canClick and FK.JustReleased(AM.action("Select"))) or FK.JustReleased(AM.action("Back")):
			GM._load_scene(SceneBefore)
			pass

func _hovered(is_hovered: bool) -> void:
	if is_hovered:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	canClick = true if is_hovered else false
