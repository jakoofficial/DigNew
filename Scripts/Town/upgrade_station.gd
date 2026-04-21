extends Area2D
@export var OverlayName: String = "Upgrades"

var canClick: bool = false
var canInteract: bool = false

func _ready() -> void:
	mouse_entered.connect(_hovered.bind(true))
	mouse_exited.connect(_hovered.bind(false))
	body_entered.connect(_player_collide)
	body_exited.connect(_player_leave)
	
func _process(_delta: float) -> void:
	if (canClick and FK.JustReleased(AM.action("Select"))) or (canInteract and FK.JustReleased(AM.action("Interact"))):
		GM._load_scene(GM.Scenes.UpgradeArea)

func _hovered(is_hovered: bool) -> void:
	if is_hovered:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		GM.curUI.emit_signal("setOverlay", OverlayName, true)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		GM.curUI.emit_signal("setOverlay", OverlayName, false)
	
	canClick = true if is_hovered else false

func _player_collide(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GM.curUI.emit_signal("setOverlay", OverlayName, true)
		canInteract = true
func _player_leave(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GM.curUI.emit_signal("setOverlay", OverlayName, false)
		canInteract = false
