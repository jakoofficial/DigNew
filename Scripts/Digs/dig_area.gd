extends Node2D

@onready var spots: Node2D = $Spots
@onready var dig_spot: Area2D = $DigSpot

func _ready() -> void:
	Generate()
	pass
	
func Generate() -> void:
	# Generation code for the dig spot areas
	for y in range(3):
		for x in range(3):
			var spot: DigSpot = dig_spot.duplicate()
			spots.add_child(spot)
			
			spot.global_position.x = 128 + (x*64) 
			spot.global_position.y = 128 + (y*64) 
