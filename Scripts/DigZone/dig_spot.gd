extends Area2D

@export_enum("Grass", "Dirt", "Unbreakable", "Bottom") var type = 1
@export var oreType: Dictionary[String, float] = {}
@onready var block: Sprite2D = $Block
@onready var oreSpr: Sprite2D = $Ore

var xIDX: int
var yIDX: int
var maxXIDX: int
var ore
var canDestroy: bool = true
func _ready() -> void:
	dug.connect(removeSpot)
	rng.randomize()
	ore = get_random_item()
	block.texture = block.texture.duplicate(true)
	_set_types()

func _set_types() -> void:
	# Block type
	if type == 0: block.frame = 0; ore = "None" # Grass
	elif type == 1: block.frame = 3
	elif type == 3: ore = "none"; block.frame = 6
	else: block.frame = 3; ore = "None"
	
	if xIDX == 0 or xIDX == maxXIDX+1: canDestroy = false
	
	# Ore type
	if xIDX > maxXIDX or !canDestroy: ore = "None"
	oreSpr.show()
	match ore:
		"None": oreSpr.hide()
		"Stone": oreSpr.frame = 4
		"Iron": oreSpr.frame = 1
		"Lapis": oreSpr.frame = 2
		"Gold": oreSpr.frame = 5

signal dug
func removeSpot() -> void:
	if canDestroy:
		if yIDX >= GM.maxY/2:
			GM.curScene.canReset = true
		
		if ore != "None":
			GM.curUI.backpack.add_item(ItemSlot.new(ore, oreSpr.frame))
		GM.curScene.use_stamina()
		call_deferred("queue_free")
	
var rng = RandomNumberGenerator.new()
func get_random_item():
	if type == 0 or type == 2: return
	var weightSum: int = 0
	for i in oreType.values():
		weightSum += i
		
	var rngSum = rng.randi_range(0, weightSum)
	for i in oreType.keys():
		if rngSum <= oreType[i]:
			return i
		rngSum-=oreType[i]
