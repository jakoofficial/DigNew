extends SkillBase
@onready var hover_info: Control = $HoverInfo

var hovered: bool = false
func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover_info.hide()

func _Activate() -> void:
	pass

func _process(delta: float) -> void:
	if hovered and Input.get_current_cursor_shape() != Input.CURSOR_POINTING_HAND:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		hover_info.show()
		hover_info._setInfo()
