extends Node

var curScene
var curUI

func _ready() -> void:
	# Keys
	AM.initAction("Left", FKS.NewKey(KEY_A), FKS.NewKey(KEY_LEFT))
	AM.initAction("Right", FKS.NewKey(KEY_D), FKS.NewKey(KEY_RIGHT))
	AM.initAction("Down", FKS.NewKey(KEY_S), FKS.NewKey(KEY_DOWN))
	AM.initAction("Dig", FKS.NewKey(KEY_SPACE))
	AM.initAction("Backpack", FKS.NewKey(KEY_B))
	AM.initAction("ResetDig", FKS.NewKey(KEY_R))
	AM.initAction("Back", FKS.NewKey(KEY_ESCAPE))

func _process(_delta: float) -> void:
	# When a dig is over
	if curScene != null and curScene.canReset:
		if FK.JustReleased(AM.action("ResetDig")):
			curScene.ResetScene()
		if FK.JustReleased(AM.action("Back")):
			await PS.add_to_global_inv(GM.curUI.backpack.inventory)
			SceneManager.change_scene_to_file("res://Scenes/town.tscn", {}, 1.0)
