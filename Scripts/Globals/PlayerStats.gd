extends Node

@export var Stamina: float = 100
@export var MaxDigs: int = 40
@export var Balance: float = 0
@export var Global_Inventory: Dictionary

func add_to_global_inv(digInv: Dictionary) -> void:
	if digInv.is_empty(): return
	
	for i in digInv.keys():
		var exists: bool = false
		for gi in Global_Inventory.keys():
			if i.ItemName == gi.ItemName:
				Global_Inventory[gi] += digInv.get(i)
				exists = true
				break
		if !exists:
			Global_Inventory[i] = digInv.get(i)
