extends CanvasLayer
@onready var new_game_btn: Button = $Control/Panel/NinePatchRect/VBoxContainer/NewGameBtn
@onready var continue_btn: Button = $Control/Panel/NinePatchRect/VBoxContainer/ContinueBtn
@onready var exit_game_btn: Button = $Control/Panel/NinePatchRect/VBoxContainer/ExitGameBtn

var canReset = false
func _ready() -> void:
	GM.curScene = self
	
	new_game_btn.connect("pressed", _NewGame)
	continue_btn.connect("pressed", _ContinueGame)
	exit_game_btn.connect("pressed", _ExitGame)
	pass

func _NewGame() -> void:
	FM.NewGameFile()
	SceneManager.change_scene_to_file("res://Scenes/Digzone.tscn", {}, 1.0)
	pass

func _ContinueGame() -> void:
	PS.SetValues(FM.LoadGame())
	SceneManager.change_scene_to_file("res://Scenes/Digzone.tscn", {}, 1.0)
	pass

func _ExitGame() -> void:
	get_tree().quit()
