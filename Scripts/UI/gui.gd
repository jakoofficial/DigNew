extends CanvasLayer

@onready var stamina: ProgressBar = $Control/Stamina
@onready var dig_over_panel: NinePatchRect = $Control/DigOverPanel

func _ready() -> void:
	GM.currUI = self
	stamina.max_value = PS._PStaminaMax
	stamina.value = PS._PStaminaCurr
	dig_over_panel.hide()

func _process(delta: float) -> void:
	if GM.digDone and dig_over_panel.visible == false:
		dig_over_panel.ShowPanel()

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
