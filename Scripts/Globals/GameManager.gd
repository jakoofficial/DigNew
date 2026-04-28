extends Node

var xSpots: int = 3
var ySpots: int = 3

var digspotHover: bool = false
var digReady = false

var digDone: bool = false
var currUI: CanvasLayer

func _ready() -> void:
	AM.initAction("L_Click", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))

func _process(delta: float) -> void:
	if PS._PStaminaCurr <= 0 and digDone == false:
		digDone = true
