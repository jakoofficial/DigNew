extends CanvasLayer

@onready var depth_level: RichTextLabel = $Control/DepthLevel
@onready var backpack: Panel = $Control/Backpack
@onready var backpack_collapser: Button = $Control/Backpack/BackpackCollapser


var backpack_shortcut = Shortcut.new()
var curPackPos: Vector2
func _ready() -> void:
	GM.curUI = self
	curPackPos = backpack.position
	
	var packShortEvent = InputEventKey.new()
	packShortEvent.keycode = KEY_B
	backpack_shortcut.events = [packShortEvent]

func _input(event: InputEvent) -> void:
	if backpack_shortcut.matches_event(event) and event.is_pressed() and not event.is_echo():
		_backpack(!backpack_collapser.button_pressed)
		get_viewport().set_input_as_handled()

func _backpack(toggled: bool) -> void:
	if toggled:
		backpack.position.x = curPackPos.x + backpack.size.x
	else:
		backpack.position.x = curPackPos.x

func set_depth_max_label() -> void:
	depth_level.text = str("Max Depth: %s" % GM.maxY)
