extends NinePatchRect

@onready var close_patches: TextureButton = $ClosePatches

func _ready() -> void:
	close_patches.connect("pressed", close)

func close() -> void:
	hide()
	pass
