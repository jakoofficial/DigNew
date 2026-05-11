extends Node

var xSpots: int = 3
var ySpots: int = 3
var canFindArtifacts: bool = true
var artifactChance: int = 0

var digspotHover: bool = false
var digReady = false

var digDone: bool = false
var currUI: CanvasLayer
var currDigArea: Node2D

var currDigType: String = "Dirt"
var digspotTypes: Dictionary = {
	"Dirt_Patch":["Dirt", 0, 2, 1],
	"Cave":["Stone", 1, 4, 2],
	"Sand_Dune":["Sand", 2, 12, 4],
	"Factory":["Iron", 3, 20, 8],
}
var digSounds: Dictionary = {
	"Dirt":["res://Sounds/Dirt/TomWinandySFX - FS_dirt_jump_01.wav", "res://Sounds/Dirt/TomWinandySFX - FS_dirt_jump_04.wav", "res://Sounds/Dirt/TomWinandySFX - FS_dirt_jump_10.wav"],
	"Stone":["res://Sounds/Cave/TomWinandySFX - FS_concrete_jump_04.wav", "res://Sounds/Cave/TomWinandySFX - FS_concrete_jump_07.wav", "res://Sounds/Cave/TomWinandySFX - FS_concrete_jump_10.wav"],
	"Sand": ["res://Sounds/SandDune/TomWinandySFX - FS_sand_jump_03.wav", "res://Sounds/SandDune/TomWinandySFX - FS_sand_jump_06.wav", "res://Sounds/SandDune/TomWinandySFX - FS_sand_jump_09.wav"],
	"Iron": ["res://Sounds/AbandonFactory/TomWinandySFX - FS_metal_jump_03.wav", "res://Sounds/AbandonFactory/TomWinandySFX - FS_metal_jump_06.wav", "res://Sounds/AbandonFactory/TomWinandySFX - FS_metal_jump_10.wav"]
}

var Artifacts: Dictionary = {
	"Dirt_Patch":["Spherical_shape", "Pretty_wrist_thing", "Electronic_rectangle"],
	"Cave":["Scribbled_parchment", "Non-protective_helmet", "Old_storage_device"]
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
	DIGAREA,
	MAINMENU
}

func load_scene(scene: Scenes) -> void:
	SceneManager.change_scene_to_file(_select_scene(scene), {}, 1.0)
	pass

func _select_scene(scene: Scenes) -> String:
	match scene:
		Scenes.MAINMENU:
			return "res://Scenes/MainMenu.tscn"
		Scenes.SKILLTREE:
			return "res://Scenes/SkillTree.tscn"
		Scenes.LEVELSELECT:
			return "res://Scenes/Level_Select.tscn"
		Scenes.DIGAREA:
			return "res://Scenes/DigArea.tscn"
	return "No scene found!"
