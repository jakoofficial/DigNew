extends Node2D

@export var digSpot: Area2D
@onready var spots: Node2D = $Spots
@onready var fence: StaticBody2D = $Fence
@onready var camera: Camera2D = $Player/Camera2D
@onready var back: Node2D = $Back

@export var startGenY: float = 128.0
@export var startGenX: float = 0.0
@export var maxSpotY: int
@export var maxSpotX: int

var maxX: int 
var maxY: int
var offset: float = 32.0
func _ready() -> void:
	randomize()
	
	back.show()
	
	maxX = (get_viewport_rect().size.x / 64)
	maxY = (get_viewport_rect().size.y / 64)
	maxSpotY = maxY+1
	maxSpotX = maxX+2
	print("%s %s", [maxSpotX, maxSpotY])
	spots.global_position = Vector2((startGenX-64.0)+offset, startGenY)
	camera.limit_right = get_viewport_rect().size.x
	
	Generated()


func Generated() -> void:
	for y in range(maxSpotY):
		for x in range(maxSpotX):
			#Fence
			if (x == 1 or x == maxX) and y==0:
				var nFence = fence.duplicate()
				spots.add_child(nFence)
				nFence.position = Vector2(x*64, y-64) 
			#Spots
			var spot = digSpot.duplicate()
			spot.xIDX = x
			spot.maxXIDX = maxX
			if y == 0: spot.type = 0 #Grass
			elif y == maxY: spot.type = 2; spot.type = 3; spot.canDestroy = false # Unbreakable
			elif x==0 or x==maxX+1: spot.type = 2; spot.canDestroy = false 
			else: spot.type = 1 #Dirt
			spots.add_child(spot)
			spot.position = Vector2(x*64, y*64)
