extends CanvasLayer

@onready var depth_level: RichTextLabel = $Control/DepthLevel
@onready var backpack: Panel = $Control/Backpack
@onready var backpack_collapser: Button = $Control/Backpack/BackpackCollapser

func _ready() -> void:
	GM.curUI = self

func _backpack(toggled: bool) -> void:
	toggled = !toggled
	if toggled:
		backpack.global_position.x = 0

func set_depth_max_label() -> void:
	depth_level.text = str("Max Depth: %s" % GM.maxY)
