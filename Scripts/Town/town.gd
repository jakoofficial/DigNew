extends Node2D

var canReset = false

func _ready() -> void:
	GM.curScene = self
	
	if GM.Player != null:
		GM.Player.global_position = GM.playerPosBuilding
	pass
