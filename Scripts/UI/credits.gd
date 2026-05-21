extends Control
const CREDIT_ITEM = preload("uid://lxwjqqp8u2ok")

var artistName: String
var artTitle: String

var credits: Dictionary[String, Array] = {
	"TomWinandySFX": ["Block Breack Sounds"],
	"mcanton": ["Scene Manager"],
	"BoldByte": [
		"Programmer: Jacob (Jay)",
		"Art: Jacob (Jay)"]
}

func _ready() -> void:
	pass
