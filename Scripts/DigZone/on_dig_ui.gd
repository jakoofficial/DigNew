extends CanvasLayer

@onready var stamina: ProgressBar = $Control/Stamina
@onready var digs_left: RichTextLabel = $Control/Stamina/DigsLeft
@onready var game_over: RichTextLabel = $Control/GameOverPanel/GameOver
@onready var game_over_panel: Panel = $Control/GameOverPanel

var digsleft: int
var curPackPos: Vector2
func _ready() -> void:
	GM.curUI = self
	game_over_panel.hide()
	#shortcut_backpack.text = str(OS.get_keycode_string((AM.action("Backpack")[0] as FancyKeyObj).btn))

func Check_GameOver() -> void:
	if digsleft <= 0:
		game_over_panel.show()
		GM.curUI.set_gameover_text("No digs left")
		GM.curScene.canReset = true
	else:
		game_over_panel.hide()

func ResetUI() -> void:
	set_stamina(0)

func set_gameover_text(reason: String):
	game_over.text = str("%s\n%s" % [reason, str("[font_size=12]Reset dig 'R' or Go back 'ESC'[/font_size]")])

func set_stamina(perc: float = 0) -> void:
	if perc == 0:
		digsleft = PS.MaxDigs
		stamina.value = GM.curScene.currStamina
		stamina.max_value = GM.curScene.currStamina
	else:
		stamina.value -= perc
		digsleft-=1
	digs_left.text = str("Digs left: %s" % digsleft)

func _process(_delta: float) -> void:
	Check_GameOver()
	
