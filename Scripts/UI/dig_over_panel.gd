extends NinePatchRect

@onready var return_btn: TextureButton = $VBoxContainer2/HBoxContainer/ReturnBtn
@onready var dig_again_btn: TextureButton = $VBoxContainer2/HBoxContainer/DigAgainBtn
@onready var collection: VBoxContainer = $VBoxContainer2/VBoxContainer/ScrollContainer/Collection
@onready var collected_item: HBoxContainer = $"../../CollectedItem"
@onready var total_balance: RichTextLabel = $VBoxContainer2/BalanceContainer/TotalBalance
@onready var dig_over_text: RichTextLabel = $VBoxContainer2/VBoxContainer/DigOverText

var digdoneText: String

func _ready() -> void:
	return_btn.connect("pressed", GM.load_scene.bind(GM.Scenes.SKILLTREE))
	dig_again_btn.connect("pressed", _ReDig)

func ShowPanel() -> void:
	dig_over_text.text = str("[wave freq=5 amp=15]%s" % digdoneText)
	show()
	scale = Vector2(0,0)
	_scale_tween()
	_setItems()

func _setItems()-> void:
	for i:DigSpot in GM.currDigArea.inventory.keys():
		var item = collected_item.duplicate()
		item.Set_Values(i)
		collection.add_child(item)
		PS._PBalance += item.Get_Value()
	total_balance.text = str("Total: %s" % PS._PBalance)

func _GoToSkills() -> void:
	GM.load_scene.bind(GM.Scenes.SKILLTREE)

func _ReDig() -> void:
	HidePanel()
	FM.SaveGame()
	GM.currDigArea.reset_dig()
	if collection.get_child_count() > 0:
		for i in collection.get_children():
			i.call_deferred("queue_free")

func HidePanel() -> void:
	scale = Vector2(1.0,1.0)
	await _scale_tween(Vector2(0,0))
	hide()

var tween: Tween
func _scale_tween(endSize: Vector2 = Vector2(1.0,1.0), time:float = 0.5) -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK)
	tween.chain().tween_property(self, "scale", endSize, time)
	pass
