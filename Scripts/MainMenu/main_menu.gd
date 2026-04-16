extends CanvasLayer
@onready var new_game_btn: Button = $Control/Panel/NinePatchRect/VBoxContainer/NewGameBtn
@onready var continue_btn: Button = $Control/Panel/NinePatchRect/VBoxContainer/ContinueBtn
@onready var exit_game_btn: Button = $Control/Panel/NinePatchRect/VBoxContainer/ExitGameBtn

func _ready() -> void:
	new_game_btn.connect("pressed", _NewGame)
	continue_btn.connect("pressed", _ContinueGame)
	exit_game_btn.connect("pressed", _ExitGame)
	pass

func _NewGame() -> void:
	FM.NewGameFile()
	pass

func _ContinueGame() -> void:
	PS.SetValues(FM.LoadGame())
	pass

func _ExitGame() -> void:
	get_tree().quit()
