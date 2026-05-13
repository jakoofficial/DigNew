extends Node

var settings_dict: Dictionary[String, Variant] = {
	"master": 0.0, # max: 0 min: -20
	"music": -0.0, # max: 0 min: -20
	"sound": -0.0, # max: 0 min: -20
	"particles": true
}

func _setBaseValues():
	settings_dict["master"] = 0.0
	settings_dict["music"] = -10.0
	settings_dict["sound"] = -10.0
	settings_dict["particles"] = true

func SetValue(setting:String, value:Variant) -> void:
	if settings_dict.has(setting):
		settings_dict[setting] = value
	

func _Load(settingsValues: Dictionary) -> void:
	if settingsValues.is_empty(): _setBaseValues(); return
	
	for k in settings_dict.keys():
		for v in settingsValues.keys():
			if k == v: 
				SetValue(k, settingsValues[v])
				print(str("k: %s" % [settingsValues[v]]))
				break
