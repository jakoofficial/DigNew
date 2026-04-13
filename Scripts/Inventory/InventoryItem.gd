class_name ItemSlot

@export var ItemName: String = ""
@export var ItemFrame: int = 0

func _init(itemname: String, itemframe: int) -> void:
	ItemName = itemname
	ItemFrame = itemframe
