extends Control
@onready var start_game: TextureButton = $VBoxContainer/StartGame
@onready var continue_game: TextureButton = $VBoxContainer/ContinueGame
@onready var quit_game: TextureButton = $VBoxContainer/QuitGame
@onready var confirm_box: Control = $ConfirmBox
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var game_version: RichTextLabel = $GameVersion
@onready var credits_control: Control = $CreditsControl
@onready var credits: TextureButton = $VBoxContainer/Credits
@onready var close_credits: TextureButton = $CreditsControl/CreditsPanel/CloseCredits

func _ready() -> void:
	FM.LoadGame()
	v_box_container.show()
	SceneManager.set_loading_screen("res://Scenes/Loading/my_load.tscn", LoadingScreen.Type.DEFAULT)
	start_game.connect("pressed", _NewGame)
	continue_game.connect("pressed", _ContinueGame)
	continue_game.disabled = !FM.CheckSaveGame()
	quit_game.connect("pressed", _QuitGame)
	game_version.text = GM.Game_Version
	credits_control.hide()
	credits.connect("pressed", _OpenCredits)
	close_credits.connect("pressed", _CloseCredits)
	if !BGMusic.playing:
		BGMusic._play_BG_Music(BGMusic.AUDIO.MainMenu)

func _process(delta: float) -> void:
	if credits_control.visible and FK.JustPressed(AM.action("SettingsMenu")):
		_CloseCredits()

func _NewGame() -> void:
	var canMakeNew = true
	if FM.CheckSaveGame():
		v_box_container.hide()
		confirm_box.show()
		confirm_box._setText("This will permanently delete the already existing savefile.")
		canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: v_box_container.show(); return
	FM.NewGameFile()
	
	GM.load_scene(GM.Scenes.SKILLTREE)

func _ContinueGame() -> void:
	PS.SetValues(FM.LoadGame())
	GM.load_scene(GM.Scenes.SKILLTREE)

func _OpenCredits() -> void:
	credits_control.show()

func _CloseCredits() -> void:
	credits_control.hide()

func _QuitGame() -> void:
	var quit = true
	v_box_container.hide()
	confirm_box.show()
	confirm_box._setText("Any unsaved data will be lost!\nQuit anyway?")
	quit = await confirm_box.confirmResult
	if !quit: v_box_container.show(); return
	get_tree().quit()
