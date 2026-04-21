extends Area2D

var canClick: bool = false

func _ready() -> void:
	mouse_entered.connect(_hovered.bind(true))
	mouse_exited.connect(_hovered.bind(false))

func _process(delta: float) -> void:
	if canClick:
		if FK.JustReleased(AM.action("Select")):
			GM._load_scene(GM.Scenes.Market)

func _hovered(is_hovered: bool) -> void:
	if is_hovered:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if GM.curUI != null:
			GM.curUI.emit_signal("setOverlay", "Market", true)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		GM.curUI.emit_signal("setOverlay", "Market", false)
	canClick = true if is_hovered else false
