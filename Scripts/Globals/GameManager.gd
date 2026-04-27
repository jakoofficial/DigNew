extends Node

var xSpots: int = 3
var ySpots: int = 3

var digspotHover: bool = false

func _ready() -> void:
	AM.initAction("L_Click", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))
