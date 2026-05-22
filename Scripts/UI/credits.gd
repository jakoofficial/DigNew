extends Control
@onready var v_box_container: VBoxContainer = $CreditsPanel/ScrollContainer/VBoxContainer

const CREDIT_ITEM = preload("uid://lxwjqqp8u2ok")

var artistName: String
var artTitle: String

var credits: Dictionary[String, Array] = {
	"Sound Effects": ["TomWinandySFX"],
	"Scene Manager Addon": ["mcanton"],
	"BoldByte": [
		"Programmer: Jacob (Jay)",
		"Art: Jacob (Jay)"],
	"Game Engine": ["Godot v4.6"]
}

func _ready() -> void:
	for c in credits.keys():
		var item = CREDIT_ITEM.instantiate()
		item.get_child(0).text = c
		for i in credits[c]:
			item.get_child(1).text += str("%s\n" % i)
		v_box_container.add_child(item)
	pass
