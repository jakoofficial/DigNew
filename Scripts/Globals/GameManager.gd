extends Node

var xSpots: int = 3
var ySpots: int = 3
var canFindArtifacts: bool = false
var artifactChance: int = 100
var artifactBonusPercent: float = 1.0
var artifactAmountAllowed: int = 1

var digspotHover: bool = false
var digReady = false

var digDone: bool = false
var currUI: CanvasLayer
var currDigArea: Node2D
var settingsMenu: Control

var Game_Version: String = "Dev-Build: b0.1"

var currDigType: String = "Dirt"
var digspotTypes: Dictionary = {
	"Dirt_Patch":["Dirt", 0, 2, 1],
	"Cave":["Stone", 1, 4, 2],
	"Sand_Dune":["Sand", 2, 12, 4],
	"Factory":["Iron", 3, 20, 8],
	"Witchy_Woods": ["Wood", 4, 30, 14],
	"Cloud_Station": ["Cloud", 5, 46, 20],
}
var digSounds: Dictionary = {
	"Dirt":["res://Sounds/Dirt/TomWinandySFX - FS_dirt_jump_01.wav", "res://Sounds/Dirt/TomWinandySFX - FS_dirt_jump_04.wav", "res://Sounds/Dirt/TomWinandySFX - FS_dirt_jump_10.wav"],
	"Stone":["res://Sounds/Cave/TomWinandySFX - FS_concrete_jump_04.wav", "res://Sounds/Cave/TomWinandySFX - FS_concrete_jump_07.wav", "res://Sounds/Cave/TomWinandySFX - FS_concrete_jump_10.wav"],
	"Sand": ["res://Sounds/SandDune/TomWinandySFX - FS_sand_jump_03.wav", "res://Sounds/SandDune/TomWinandySFX - FS_sand_jump_06.wav", "res://Sounds/SandDune/TomWinandySFX - FS_sand_jump_09.wav"],
	"Iron": ["res://Sounds/AbandonFactory/TomWinandySFX - FS_metal_jump_03.wav", "res://Sounds/AbandonFactory/TomWinandySFX - FS_metal_jump_06.wav", "res://Sounds/AbandonFactory/TomWinandySFX - FS_metal_jump_10.wav"],
	"Wood": ["res://Sounds/WitchyWoods/TomWinandySFX - FS_wood_jump_03.wav", "res://Sounds/WitchyWoods/TomWinandySFX - FS_wood_jump_06.wav", "res://Sounds/WitchyWoods/TomWinandySFX - FS_wood_jump_10.wav"],
	"Cloud": ["res://Sounds/CloudStation/TomWinandySFX - FS_snow_jump_04.wav", "res://Sounds/CloudStation/TomWinandySFX - FS_snow_jump_08.wav", "res://Sounds/CloudStation/TomWinandySFX - FS_snow_jump_10.wav"],
}

var Artifacts: Dictionary = {
	"Dirt_Patch":["Spherical_shape", "Pretty_wrist_thing", "Electronic_rectangle"],
	"Cave":["Scribbled_parchment", "Non-protective_helmet", "Old_storage_device"],
	"Sand_Dune":["Old_era_entertainment", "Liqiud_container", "Fossil"],
	"Factory":["Primitive_electronic_component", "Small_gear", "Wrench"],
	"Witchy_Woods":["Cauldron", "Wand_like_stick", "Pointy_hat"],
	"Cloud_Station":["Rain_droplet", "Chunk_o'_Cloud", "Bottled_thunder"],
}

func _ready() -> void:
	AM.initAction("L_Click", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))
	AM.initAction("R_Click", FKS.NewKey(MOUSE_BUTTON_RIGHT, FKS.InputType.Mouse))
	AM.initAction("ZoomIn", FKS.NewKey(MOUSE_BUTTON_WHEEL_UP, FKS.InputType.Mouse), FKS.NewKey(KEY_E))
	AM.initAction("ZoomOut", FKS.NewKey(MOUSE_BUTTON_WHEEL_DOWN, FKS.InputType.Mouse), FKS.NewKey(KEY_Q))
	AM.initAction("SettingsMenu", FKS.NewKey(KEY_ESCAPE))

func _process(delta: float) -> void:
	if settingsMenu != null:
		if FK.JustReleased(AM.action("SettingsMenu")):
			if settingsMenu.visible != true: settingsMenu._ShowMenu()
			else: settingsMenu._HideMenu()
	
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

func load_scene(scene: Scenes, minTime: float = 0.25) -> void:
	SceneManager.change_scene_to_file(_select_scene(scene), {}, minTime)
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
