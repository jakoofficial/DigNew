extends Node2D

@onready var spots: Node2D = $Spots
@onready var dig_spot: Area2D = $DigSpot
@onready var cursor: Sprite2D = $Cursor
@onready var gui: CanvasLayer = $GUI

var vSize: Vector2

var inventory: Dictionary[DigSpot, int]

func _ready() -> void:
	GM.currDigArea = self
	GM.digDone = false
	PS._PStaminaCurr = PS._PStaminaMax
	gui.ResetUI()
	inventory.clear()
	setCursor.connect(setCursorPos)
	vSize = get_viewport_rect().size
	Generate()
	pass

func _process(delta: float) -> void:
	if GM.digspotHover: cursor.show()
	else: cursor.hide()

func addToInv(collected: DigSpot) -> void:
	for i in inventory.keys():
		if i._Name == collected._Name:
			inventory[i] += 1
			return
	var newitem: DigSpot
	newitem = collected.duplicate()
	inventory[newitem] = 1
	collected = null

signal setCursor
func setCursorPos(pos = Vector2.ZERO) -> void:
	if pos == Vector2.ZERO: pos = Vector2(-500, -500)
	cursor.global_position = pos

#func _draw() -> void:
	#draw_line(Vector2(vSize.x/2,0), Vector2(vSize.x/2, vSize.y), Color.WHITE, 1)
	#draw_line(Vector2(0,vSize.y/2), Vector2(vSize.x, vSize.y/2), Color.WHITE, 1)

func reset_dig() -> void:
	GM.digDone = false
	PS._PStaminaCurr = PS._PStaminaMax
	inventory.clear()
	gui.ResetUI()
	
	if spots.get_child_count() > 0:
		for c in spots.get_children():
			c.reparent(get_tree().root)
			c.call_deferred("queue_free")
	Generate()

func Generate() -> void:
	GM.digReady = false
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
			spot._Value += PS._PValueBonus
			spots.add_child(spot)
			spot.digZone = self
			spot.hide()
			# Position each spot with spacing
			spot.global_position.x = spawnStartX + (x * (spotSize + spacing))+pivot_offset
			spot.global_position.y = spawnStartY + (y * (spotSize + spacing))+pivot_offset
	
	var time: float = 1.0
	if spots.get_child_count() > 0:
		for c in spots.get_children():
			c.show()
			c.Spawn()
			await get_tree().create_timer(time/(GM.xSpots*GM.ySpots)).timeout
		
	GM.digReady = true
