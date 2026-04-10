extends CanvasLayer

@onready var depth_level: RichTextLabel = $Control/DepthLevel

func _ready() -> void:
	GM.curUI = self

func set_depth_max_label() -> void:
	depth_level.text = str("Max Depth: %s" % GM.maxY)
