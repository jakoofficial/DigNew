extends CanvasLayer
@onready var go_dig_btn: TextureButton = $Skilltree/GoDigBtn
@onready var skills: Node2D = $"../Skills"
@onready var player_balance: RichTextLabel = $Skilltree/HBoxContainer/PlayerBalance
@onready var menu_btn: TextureButton = $Skilltree/MenuBtn

func _ready() -> void:
	go_dig_btn.connect("pressed", _GoDig)
	menu_btn.connect("pressed", _GoToMenu)
	
	if BGMusic.playing and BGMusic.curAudio == BGMusic.AUDIO.MainMenu:
		BGMusic.fade(true, Settings.settings_dict["music"])
		BGMusic._play_BG_Music(BGMusic.AUDIO.Level1)

func _process(delta: float) -> void:
	if player_balance.text != str(PS._PBalance):
		player_balance.text = str(PS._PBalance)

func _GoToMenu() -> void:
	FM.SaveGame()
	GM.load_scene(GM.Scenes.MAINMENU)

func _GoDig() -> void:
	FM.SaveGame()
	GM.load_scene(GM.Scenes.LEVELSELECT)
