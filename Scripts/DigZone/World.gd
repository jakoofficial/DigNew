extends Node2D

@export var digSpot: Area2D
@onready var spots: Node2D = $Spots
@onready var fence: StaticBody2D = $Fence
@onready var camera: Camera2D = $Player/Camera2D
@onready var back: Node2D = $Back
@onready var cursor: Sprite2D = $Cursor

@export var startGenY: float = 128.0
@export var startGenX: float = 0.0
@export var maxSpotY: int
@export var maxSpotX: int

var startPlayerPos: Vector2

var offset: float = 32.0
var is_ready: bool = false
var canReset: bool = false

# Playerstats
var currStamina: float = PS.Stamina
var perc: float = currStamina / PS.MaxDigs

func _ready() -> void:
	GM.curScene = self
	back.show()
	randomize()
	
	GM.maxX = (get_viewport_rect().size.x / 64)
	GM.maxY = (get_viewport_rect().size.y / 64)
	maxSpotY = GM.maxY+1
	maxSpotX = GM.maxX+2
	spots.global_position = Vector2((startGenX-64.0)+offset, startGenY)
	camera.limit_right = get_viewport_rect().size.x
	is_ready = await Generated()
	GM.curUI.set_depth_max_label()
	GM.curUI.set_stamina(0)

func use_stamina() -> void:
	if currStamina > 0:
		currStamina -= perc
		GM.curUI.set_stamina(perc)

func ResetScene() -> void:
	if canReset:
		await PS.add_to_global_inv(GM.curUI.backpack.inventory)
		canReset = false
		$Player.global_position = startPlayerPos
		currStamina = PS.Stamina
		GM.curUI.backpack.clear_backpack()
		GM.curUI.set_stamina(0)
		GM.curUI.ResetUI()
		Generated()

func Generated() -> bool:
	if spots.get_child_count() > 0:
		for i in spots.get_children():
			i.queue_free()
	
	for y in range(maxSpotY):
		for x in range(maxSpotX):
			#Fence
			if (x == 1 or x == GM.maxX) and y==0:
				var nFence = fence.duplicate()
				spots.add_child(nFence)
				nFence.position = Vector2(x*64, y-64) 
				if x == GM.maxX: nFence.scale.x = -nFence.scale.x
			#Spots
			var spot = digSpot.duplicate()
			spot.xIDX = x
			spot.yIDX = y
			spot.maxXIDX = GM.maxX
			if y == 0: spot.type = 0 #Grass
			elif y == GM.maxY: spot.type = 2; spot.type = 3; spot.canDestroy = false # Unbreakable
			elif x==0 or x==GM.maxX+1: spot.type = 2; spot.canDestroy = false 
			else: spot.type = 1 #Dirt
			spots.add_child(spot)
			spot.position = Vector2(x*64, y*64)
	return true
