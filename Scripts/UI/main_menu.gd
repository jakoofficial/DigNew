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
@onready var intro: Control = $Intro
@onready var last_played_label: RichTextLabel = $LastPlayedLabel
@onready var settings_btn: TextureButton = $VBoxContainer/SettingsBtn
@onready var patch_notes: TextureButton = $PatchNotes

func _ready() -> void:
	var data = FM.LoadGame()
	if data != null:
		Settings._Load(data["Settings"] as Dictionary)
	if data!= null and data.has("GameVersion") and data["GameVersion"] != GM.Game_Version:
		var canMakeNew = true
		v_box_container.hide()
		confirm_box.showSpecial("Understood")
		confirm_box._setText("[font_size=14]A save file have been found that might not work with this version of the game.\n\nA new save is recommended")
		canMakeNew = await confirm_box.confirmResult
	
	confirm_box.resetButtons()
	v_box_container.show()
	SceneManager.set_loading_screen("res://Scenes/Loading/my_load.tscn", LoadingScreen.Type.DEFAULT)
	start_game.connect("pressed", _NewGame)
	continue_game.connect("pressed", _ContinueGame)
	continue_game.disabled = !FM.CheckSaveGame()
	quit_game.connect("pressed", _QuitGame)
	credits_control.hide()
	credits.connect("pressed", _OpenCredits)
	close_credits.connect("pressed", _CloseCredits)
	settings_btn.connect("pressed", showMenu)
	patch_notes.connect("pressed", OpenPatchNotes)
	
	game_version.text = str("%s %s" % [GM.Export_Version, GM.Game_Version])
	
	if data != null and data.has("LastPlayed"):
		PS._last_time_played	= data["LastPlayed"] as Dictionary
		last_played_label.show()
		last_played_label.text = str("%02d-%02d-%s %02d:%02d" % [PS._last_time_played.get("day"), PS._last_time_played.get("month"), PS._last_time_played.get("year"),PS._last_time_played.get("hour"), PS._last_time_played.get("minute")])
	else:
		last_played_label.hide()
	
	if GM._IntroPlayed:
		intro.hide()
	else:
		intro.show()
		intro.play_intro()

func OpenPatchNotes() -> void:
	OS.shell_open("https://github.com/jakoofficial/DigNew/discussions/2")
	pass

func showMenu() -> void:
	if GM.settingsMenu != null and GM.settingsMenu.visible != true:
		GM.settingsMenu._ShowMenu()
	elif GM.settingsMenu.visible:
		GM.settingsMenu.confirm_changes()

func _process(delta: float) -> void:
	if !GM._IntroPlayed: return
	elif GM._IntroPlayed and BGMusic.playing and BGMusic.curAudio != BGMusic.AUDIO.MainMenu:
		BGMusic.Fade = BGMusic.FADE.OutIn
		await BGMusic.FadeFinished
		BGMusic._play_BG_Music(BGMusic.AUDIO.MainMenu)
	
	if GM.settingsMenu.visible and FK.JustPressed(AM.action("DigOver")):
		GM.settingsMenu.confirm_changes()
	
	if credits_control.visible and FK.JustPressed(AM.action("DigOver")):
		_CloseCredits()

func _NewGame() -> void:
	var canMakeNew = true
	if FM.CheckSaveGame():
		v_box_container.hide()
		confirm_box.show()
		confirm_box._setText("This will permanently delete the already existing save file.")
		canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: v_box_container.show(); return
	FM.NewGameFile()
	
	GM.LoadedGame = true
	GM.load_scene(GM.Scenes.SKILLTREE)

func _ContinueGame() -> void:
	PS.SetValues(FM.LoadGame())
	GM.LoadedGame = true
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
