extends Node

var settings_dict: Dictionary[String, Variant] = {
	"master": 0.0, # max: 0 min: -20
	"music": -10.0, # max: 0 min: -20
	"sound": -10.0, # max: 0 min: -20
	"particles": true,
	"font": FONTS.PIXELATED,
}

enum FONTS {
	PIXELATED, SYSTEM,
}

func _setBaseValues():
	settings_dict["master"] = 0.0
	settings_dict["music"] = -10.0
	settings_dict["sound"] = -10.0
	settings_dict["particles"] = true
	settings_dict["font"] = FONTS.PIXELATED

func SetValue(setting:String, value:Variant) -> void:
	if settings_dict.has(setting):
		settings_dict[setting] = value
	

func _Load(settingsValues: Dictionary) -> void:
	if settingsValues.is_empty(): _setBaseValues(); return
	
	for k in settings_dict.keys():
		for v in settingsValues.keys():
			if k == v: 
				SetValue(k, settingsValues[v])
				if k == "music":
					print(settings_dict["music"])
					BGMusic.loadedLevel = settings_dict["music"]
				break

func ChangeFont(fontChange: FONTS):
	# Create a new theme
	var theme = Theme.new()
	
	var custom_font
	match fontChange:
		FONTS.PIXELATED:
			custom_font = load("res://Themes/Font/Pixeled.ttf")
		FONTS.SYSTEM:
			custom_font = load("res://Themes/Font/SystemFont.tres")

	# Set the font for all control types
	#theme.set_font("font", "Label", custom_font)
	#theme.set_font("font", "Button", custom_font)
	#theme.set_font("font", "Button", custom_font)
	#theme.set_font("font", "ProgressBar", custom_font)
	
	theme.default_font = custom_font
	
	SetValue("font", fontChange)

	# Apply the theme to the root of your scene
	get_tree().root.set_theme(theme)
	#print(theme.default_font)
