extends CanvasLayer
@onready var go_dig_btn: TextureButton = $Skilltree/GoDigBtn

func _ready() -> void:
	go_dig_btn.connect("pressed", _GoDig)

func _GoDig() -> void:
	GM.load_scene(GM.Scenes.DIGAREA)
