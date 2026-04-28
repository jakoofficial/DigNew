extends NinePatchRect

@onready var return_btn: TextureButton = $VBoxContainer2/HBoxContainer/ReturnBtn
@onready var dig_again_btn: TextureButton = $VBoxContainer2/HBoxContainer/DigAgainBtn

func _ready() -> void:
	return_btn.connect("pressed", GM.load_scene.bind(GM.Scenes.SKILLTREE))

func ShowPanel() -> void:
	show()
	scale = Vector2(0,0)
	_scale_tween()

func HidePanel() -> void:
	scale = Vector2(1.0,1.0)
	await _scale_tween(Vector2(0,0))
	hide()

var tween: Tween
func _scale_tween(endSize: Vector2 = Vector2(1.0,1.0), time:float = 0.5) -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK)
	#tween.tween_property(self, "scale", Vector2(0.0, 0.0), 0.0)
	tween.chain().tween_property(self, "scale", endSize, time)
	pass
