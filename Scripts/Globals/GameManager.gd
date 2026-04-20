extends Node

var curScene
var curUI

enum Scenes {
	MainMenu,
	Town,
	DigZone,
	UpgradeArea,
	Market
}

func _ready() -> void:
	# Keys
	AM.initAction("Left", FKS.NewKey(KEY_A), FKS.NewKey(KEY_LEFT))
	AM.initAction("Right", FKS.NewKey(KEY_D), FKS.NewKey(KEY_RIGHT))
	AM.initAction("Down", FKS.NewKey(KEY_S), FKS.NewKey(KEY_DOWN))
	AM.initAction("Dig", FKS.NewKey(KEY_SPACE))
	AM.initAction("Backpack", FKS.NewKey(KEY_B))
	AM.initAction("ResetDig", FKS.NewKey(KEY_R))
	AM.initAction("Back", FKS.NewKey(KEY_ESCAPE))
	AM.initAction("Select", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))

func _process(_delta: float) -> void:
	# When a dig is over
	if curScene != null and curScene.canReset:
		if FK.JustReleased(AM.action("ResetDig")):
			curScene.ResetScene()
		if FK.JustReleased(AM.action("Back")):
			await PS.add_to_global_inv(GM.curUI.backpack.inventory)
			_load_scene(Scenes.Town)

var SceneEntering: String = "asd"
func _load_scene(scene: Scenes) -> void:
	var path = "res://Scenes/main_menu.tscn"
	
	match scene:
		0: path = "res://Scenes/main_menu.tscn"; SceneEntering = "Main Menu"
		1: path = "res://Scenes/town.tscn"; SceneEntering = "Town"
		2: path = "res://Scenes/Digzone.tscn"; SceneEntering = "Dig Zone"
		3: path = "res://Scenes/Upgrade_Area.tscn"; SceneEntering = "Upgrade Area"
		4: path = "res://Scenes/market.tscn"; SceneEntering = "Market"
	
	SceneManager.change_scene_to_file(path, {}, 1.0)
