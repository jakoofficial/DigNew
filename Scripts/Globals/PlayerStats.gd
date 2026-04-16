extends Node

@export var Stamina: float = 100
@export var MaxDigs: int = 4
@export var Balance: float = 0
@export var Global_Inventory: Dictionary
@export var MaxDigX: int = 18
@export var MaxDigY: int = 10

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

func SetValues(data: Dictionary) -> void:
	for d in data.keys():
		print(d)
	pass
