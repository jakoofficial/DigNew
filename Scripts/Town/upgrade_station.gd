extends Area2D

var canClick: bool = false

func _ready() -> void:
	mouse_entered.connect(_hovered.bind(true))
	mouse_exited.connect(_hovered.bind(false))

func _process(_delta: float) -> void:
	if canClick:
		if FK.JustReleased(AM.action("Select")):
			# Opens the upgrade menu
			GM._load_scene(GM.Scenes.UpgradeArea)
			pass

func _hovered(is_hovered: bool) -> void:
	if is_hovered:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		GM.curUI.emit_signal("setOverlay", "Upgrades", true)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		GM.curUI.emit_signal("setOverlay", "Upgrades", false)
	
	canClick = true if is_hovered else false
