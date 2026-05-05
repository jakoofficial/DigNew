extends Node

var xSpots: int = 3
var ySpots: int = 3

var digspotHover: bool = false
var digReady = false

var digDone: bool = false
var currUI: CanvasLayer
var currDigArea: Node2D

var currDigType: String = "Dirt"
var digspotTypes: Dictionary = {
	"Dirt":["Dirt", 0, 2, 1],
	"Stone":["Stone", 1, 4, 2],
	"Sandstone":["Sandstone", 2, 12, 4],
	"Iron":["Iron", 3, 20, 8],
}

func _ready() -> void:
	AM.initAction("L_Click", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))
	AM.initAction("R_Click", FKS.NewKey(MOUSE_BUTTON_RIGHT, FKS.InputType.Mouse))
	AM.initAction("ZoomIn", FKS.NewKey(MOUSE_BUTTON_WHEEL_UP, FKS.InputType.Mouse), FKS.NewKey(KEY_E))
	AM.initAction("ZoomOut", FKS.NewKey(MOUSE_BUTTON_WHEEL_DOWN, FKS.InputType.Mouse), FKS.NewKey(KEY_Q))

func _process(delta: float) -> void:
	if PS._PStaminaCurr <= 0 and digDone == false:
		currUI.dig_over_panel.digdoneText = "No stamina left"
		digDone = true

var LevelSelectDict: Dictionary[String, bool]

enum Scenes {
	SKILLTREE,
	LEVELSELECT,
	DIGAREA
}

func load_scene(scene: Scenes) -> void:
	SceneManager.change_scene_to_file(_select_scene(scene), {}, 1.0)
	pass

func _select_scene(scene: Scenes) -> String:
	match scene:
		Scenes.SKILLTREE:
			return "res://Scenes/SkillTree.tscn"
		Scenes.LEVELSELECT:
			return "res://Scenes/Level_Select.tscn"
		Scenes.DIGAREA:
			return "res://Scenes/DigArea.tscn"
	return "No scene found!"
