extends Area2D

var canClick: bool = false

func _ready() -> void:
	mouse_entered.connect(_hovered.bind(true))
	mouse_exited.connect(_hovered.bind(false))

func _process(delta: float) -> void:
	if canClick:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if FK.JustReleased(AM.action("Select")):
			GM._load_scene(GM.Scenes.DigZone)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _hovered(is_hovered: bool) -> void:
	canClick = true if is_hovered else false
