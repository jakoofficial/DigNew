extends Node

var xSpots: int = 9
var ySpots: int = 9

var digspotHover: bool = false
var digReady = false

func _ready() -> void:
	AM.initAction("L_Click", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))
