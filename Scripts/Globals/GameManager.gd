extends Node

var curScene
var curUI

var maxX: int 
var maxY: int

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_released() and event.keycode == KEY_R:
			if curScene != null and curScene.canReset:
				curScene.ResetScene()
