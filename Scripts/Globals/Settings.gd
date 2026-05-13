extends Node

var settings_dict: Dictionary[String, Variant] = {
	"master": 0.0,
	"music": -0.5,
	"sound": -0.5,
	"particles": true
}

func _setBaseValues():
	settings_dict["master"] = 0.0
	settings_dict["music"] = -0.5
	settings_dict["sound"] = -0.5
	settings_dict["particles"] = true

func SetValue(setting:String, value:Variant) -> void:
	if settings_dict.has(setting):
		settings_dict[setting] = value
