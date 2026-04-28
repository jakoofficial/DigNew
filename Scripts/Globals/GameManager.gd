extends Node

var xSpots: int = 3
var ySpots: int = 3

var digspotHover: bool = false
var digReady = false

var digDone: bool = false
var currUI: CanvasLayer
var currDigArea: Node2D

func _ready() -> void:
	AM.initAction("L_Click", FKS.NewKey(MOUSE_BUTTON_LEFT, FKS.InputType.Mouse))

func _process(delta: float) -> void:
	if PS._PStaminaCurr <= 0 and digDone == false:
		digDone = true

enum Scenes {
	SKILLTREE,
	DIGAREA
}

func load_scene(scene: Scenes) -> void:
	SceneManager.change_scene_to_file(_select_scene(scene), {}, 1.0)
	pass

func _select_scene(scene: Scenes) -> String:
	match scene:
		Scenes.SKILLTREE:
			return "res://Scenes/SkillTree.tscn"
		Scenes.DIGAREA:
			return "res://Scenes/DigArea.tscn"
	return "No scene found!"
