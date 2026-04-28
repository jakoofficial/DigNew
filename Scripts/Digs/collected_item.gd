extends HBoxContainer

func Set_Values(item: DigSpot) -> void:
	#item_texture
	$ItemName.text = str("%s (%s)" % [item._Name, GM.currDigArea.inventory.get(item)])
	$Value.text = str("%s" % [(item._Value*GM.currDigArea.inventory.get(item))])

func Get_Value() -> int:
	return int($Value.text)
