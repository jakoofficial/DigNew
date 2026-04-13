extends CanvasLayer

@onready var depth_level: RichTextLabel = $Control/DepthLevel
@onready var backpack: Panel = $Control/Backpack

var curPackPos: Vector2
func _ready() -> void:
	GM.curUI = self
	curPackPos = backpack.position
	_backpack()

func _process(_delta: float) -> void:
	if FK.JustPressed(AM.action("Backpack")):
		_backpack()

var toggle: bool = true
func _backpack() -> void:
	toggle = !toggle
	if toggle: backpack.show()
	else: backpack.hide()

func set_depth_max_label() -> void:
	depth_level.text = str("Max Depth: %s" % GM.maxY)
