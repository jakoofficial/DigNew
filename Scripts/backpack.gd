extends Panel
@onready var inventory_container: FlowContainer = $Inventory

const PACK_SLOT = preload("uid://c6pd0saki0y7d")

var inventory: Dictionary[ItemSlot, int] = {}

func add_item(item: ItemSlot) -> void:
	if item == null: return
	
	for i in inventory:
		if i.ItemName == item.ItemName:
			inventory[i] += 1
			return
	inventory[item] = 1
