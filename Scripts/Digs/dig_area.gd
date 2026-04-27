extends Node2D

@onready var spots: Node2D = $Spots
@onready var dig_spot: Area2D = $DigSpot
@onready var cursor: Sprite2D = $Cursor

var vSize: Vector2

func _ready() -> void:
	setCursor.connect(setCursorPos)
	
	vSize = get_viewport_rect().size
	
	Generate()
	pass

func _process(delta: float) -> void:
	if GM.digspotHover: cursor.show()
	else: cursor.hide()

signal setCursor
func setCursorPos(pos = Vector2.ZERO) -> void:
	if pos == Vector2.ZERO: pos = Vector2(-500, -500)
	cursor.global_position = pos

#func _draw() -> void:
	#draw_line(Vector2(vSize.x/2,0), Vector2(vSize.x/2, vSize.y), Color.WHITE, 1)
	#draw_line(Vector2(0,vSize.y/2), Vector2(vSize.x, vSize.y/2), Color.WHITE, 1)

func Generate() -> void:
	var spacing = 2       # Spacing between spots
	var spotSize = 64     # Size of each spot (64x64)
	var pivot_offset = spotSize / 2 # Offset of the size of the spot

	# Calculate the total width and height of the grid, including spacing
	var totalWidth = (GM.xSpots * spotSize) + ((GM.xSpots - 1) * spacing)
	var totalHeight = (GM.ySpots * spotSize) + ((GM.ySpots - 1) * spacing)

	# Calculate the starting position to center the grid in the viewport
	var spawnStartX = (vSize.x - totalWidth) / 2
	var spawnStartY = (vSize.y - totalHeight) / 2

	for y in range(GM.ySpots):
		for x in range(GM.xSpots):
			var spot: DigSpot = dig_spot.duplicate()
			spot.area = self
			spots.add_child(spot)

			# Position each spot with spacing
			spot.global_position.x = spawnStartX + (x * (spotSize + spacing))+pivot_offset
			spot.global_position.y = spawnStartY + (y * (spotSize + spacing))+pivot_offset
