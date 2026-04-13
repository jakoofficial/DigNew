extends Panel
@onready var inventory_container: FlowContainer = $Inventory

const PACK_SLOT = preload("uid://c6pd0saki0y7d")

var inventory: Dictionary[ItemSlot, int] = {}

func add_item(item: ItemSlot) -> void:
	if item == null: return
	
	for i in inventory:
		if i.ItemName == item.ItemName:
			inventory[i] += 1
			_add_to_inv(item, inventory.get(i), false)
			return
	inventory[item] = 1
	_add_to_inv(item, inventory.get(item), true)

func _add_to_inv(item: ItemSlot, amount: int, new: bool) -> void:
	if new:
		var newitem = PACK_SLOT.instantiate()
		newitem.amount = inventory.get(item)
		newitem.item_frame = item.ItemFrame
		newitem.item_name = item.ItemName
		inventory_container.add_child(newitem)
	else:
		for i in inventory_container.get_children():
			if item.ItemName == i.item_name:
				i.amount = amount
				i.updateSlot()
				return

func clear_backpack() -> void:
	for b in inventory_container.get_children():
		b.call_deferred("queue_free")
	inventory.clear()
