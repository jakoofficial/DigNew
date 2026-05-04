extends Control
@onready var start_game: TextureButton = $VBoxContainer/StartGame
@onready var continue_game: TextureButton = $VBoxContainer/ContinueGame
@onready var confirm_box: Control = $ConfirmBox
@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	FM.LoadGame()
	print(FM.CurrSaveFile)
	v_box_container.show()
	SceneManager.set_loading_screen("res://Scenes/Loading/my_load.tscn", LoadingScreen.Type.DEFAULT)
	start_game.connect("pressed", _NewGame)
	continue_game.connect("pressed", _ContinueGame)
	continue_game.disabled = !FM.CheckSaveGame()

func _NewGame() -> void:
	var canMakeNew = true
	if FM.CheckSaveGame():
		v_box_container.hide()
		confirm_box.show()
		#confirm_box.prev_btn = start_game
		confirm_box._setText("This will permanently delete the already existing savefile.")
		canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: v_box_container.show(); return
	FM.NewGameFile()
	
	GM.load_scene(GM.Scenes.SKILLTREE)

func _ContinueGame() -> void:
	PS.SetValues(FM.LoadGame())
	GM.load_scene(GM.Scenes.SKILLTREE)
