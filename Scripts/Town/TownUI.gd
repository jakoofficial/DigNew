extends Control

@onready var overlay_text: Panel = $OverlayText
@onready var title: RichTextLabel = $OverlayText/BG/Title

func _ready() -> void:
	GM.curUI = self
	setOverlay.connect(_SetOverlay)

signal setOverlay
func _SetOverlay(text: String, vis: bool = false) -> void:
	overlay_text.visible = vis
	title.text = text
