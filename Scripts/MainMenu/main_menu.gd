extends CanvasLayer
@onready var new_game_btn: TextureButton = $Control/Panel/NinePatchRect/VBoxContainer/NewGameBtn
@onready var continue_btn: TextureButton = $Control/Panel/NinePatchRect/VBoxContainer/ContinueBtn
@onready var exit_game_btn: TextureButton = $Control/Panel/NinePatchRect/VBoxContainer/ExitGameBtn
@onready var confirm_box: Control = $ConfirmBox

var canReset = false
func _ready() -> void:
	GM.curScene = self
	SceneManager.set_loading_screen("res://Scenes/Loading/my_load.tscn", LoadingScreen.Type.DEFAULT)
	
	new_game_btn.connect("pressed", _NewGame)
	continue_btn.connect("pressed", _ContinueGame)
	exit_game_btn.connect("pressed", _ExitGame)
	
	new_game_btn.grab_focus()
	
	continue_btn.disabled = !FM.CheckSaveGame()
	if !FM.CheckSaveGame():
		continue_btn.focus_mode = Control.FOCUS_NONE

func _NewGame() -> void:
	var canMakeNew = true
	if FM.CheckSaveGame():
		confirm_box.show()
		confirm_box.prev_btn = new_game_btn
		confirm_box._setText("This will permanently delete the already existing savefile.")
		canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: return
	FM.NewGameFile()
	GM.playerPosBuilding = Vector2(32, 304)

	GM._load_scene(GM.Scenes.Town)

func _ContinueGame() -> void:
	PS.SetValues(FM.LoadGame())
	GM.playerPosBuilding = Vector2(32, 304)
	
	GM._load_scene(GM.Scenes.Town)

func _ExitGame() -> void:
	get_tree().quit()
