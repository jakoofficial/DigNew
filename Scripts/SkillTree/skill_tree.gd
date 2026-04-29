extends Control
@onready var go_dig_btn: TextureButton = $GoDigBtn

func _ready() -> void:
	go_dig_btn.connect("pressed", _GoDig)

func _GoDig() -> void:
	#GM.digDone = false
	#PS._PStaminaCurr = PS._PStaminaMax
	GM.load_scene(GM.Scenes.DIGAREA)
