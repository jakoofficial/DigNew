extends Node2D
@onready var pause_menu: Control = $CanvasLayer/PauseMenu

var canReset = false
var canPause: bool = true

func _ready() -> void:
	GM.curScene = self
	pause_menu.town.disabled = true
	pause_menu.town.focus_mode = Control.FOCUS_NONE
	
	if GM.Player != null:
		GM.Player.global_position = GM.playerPosBuilding
	pass
