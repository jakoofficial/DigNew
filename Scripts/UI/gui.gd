extends CanvasLayer

@onready var stamina: ProgressBar = $Control/Stamina
@onready var dig_over_panel: NinePatchRect = $Control/DigOverPanel
@onready var end_dig_btn: TextureButton = $Control/EndDigBtn

func _ready() -> void:
	GM.currUI = self
	stamina.max_value = PS._PStaminaMax
	stamina.value = PS._PStaminaCurr
	dig_over_panel.hide()
	end_dig_btn.show()
	end_dig_btn.pressed.connect(_EndDigPressed)

func _process(delta: float) -> void:
	if GM.digDone and dig_over_panel.visible == false:
		end_dig_btn.hide()
		dig_over_panel.ShowPanel()

func _EndDigPressed() -> void:
	GM.load_scene(GM.Scenes.SKILLTREE)

func ResetUI() -> void:
	stamina.value = PS._PStaminaMax

func UpdateUI() -> void:
	stamina.value = PS._PStaminaCurr
	_shake()

var tween: Tween
func _shake() -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(stamina).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Control/Stamina, "scale", Vector2(0.95, 0.95), 0.05)
	tween.chain().tween_property($Control/Stamina, "scale", Vector2(1.0, 1.0), 0.1)
	pass
