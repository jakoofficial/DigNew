extends Node2D

@export var digSpot: Area2D
@onready var spots: Node2D = $Spots
@onready var cursor: Sprite2D = $Cursor

@export var startGenY: float = 128.0
@export var startGenX: float = 120.0
@export var maxSpotY: int
@export var maxSpotX: int

var startPlayerPos: Vector2

var offset: float = 32.0
var is_ready: bool = false

# Playerstats
var currStamina: float = PS.Stamina
var perc: float = currStamina / PS.MaxDigs
var canPause: bool = true

func _ready() -> void:
	GM.curScene = self
	randomize()
	
	maxSpotY = PS.MaxDigY+1
	maxSpotX = PS.MaxDigX+2
	spots.global_position = Vector2((startGenX-64.0)+offset, startGenY)
	Generated()
	GM.curUI.set_stamina(0)

func use_stamina() -> void:
	if currStamina > 0:
		currStamina -= perc
		GM.curUI.set_stamina(perc)

func ResetScene() -> void:
	currStamina = PS.Stamina
	GM.curUI.set_stamina(0)
	GM.curUI.ResetUI()
	Generated()

func Generated() -> void:
	if spots.get_child_count() > 0:
		for i in spots.get_children():
			i.queue_free()
	
