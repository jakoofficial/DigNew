extends Node

var curScene
var curUI

var maxX: int 
var maxY: int

func _ready() -> void:
	# Keys
	AM.initAction("Left", FKS.NewKey(KEY_A), FKS.NewKey(KEY_LEFT))
	AM.initAction("Right", FKS.NewKey(KEY_D), FKS.NewKey(KEY_RIGHT))
	AM.initAction("Down", FKS.NewKey(KEY_S), FKS.NewKey(KEY_DOWN))
	AM.initAction("Dig", FKS.NewKey(KEY_SPACE))
	AM.initAction("Backpack", FKS.NewKey(KEY_B))
	AM.initAction("ResetDig", FKS.NewKey(KEY_R))

func _process(_delta: float) -> void:
	if FK.JustReleased(AM.action("ResetDig")):
		if curScene != null and curScene.canReset:
			curScene.ResetScene()
