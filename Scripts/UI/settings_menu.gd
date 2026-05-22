extends Control

@onready var master_volume_slider: HSlider = $Backpiece/Container/S_Master/MasterVolumeSlider
@onready var music_volume_slider: HSlider = $Backpiece/Container/S_Music/MusicVolumeSlider
@onready var sound_volume_slider: HSlider = $Backpiece/Container/S_Sound/SoundVolumeSlider
@onready var particel_check_box: CheckButton = $Backpiece/Container/HBoxContainer/ParticelCheckBox
@onready var font_check_box: CheckButton = $Backpiece/Container/HBoxContainer2/FontCheckBox

@onready var cancel_btn: TextureButton = $HBoxContainer/CancelBtn
@onready var confirm_btn: TextureButton = $HBoxContainer/ConfirmBtn
@onready var reset_btn: TextureButton = $Backpiece2/ResetBtn
@onready var confirm_box: Control = $ConfirmBox

func _ready() -> void:
	GM.settingsMenu = self
	
	font_check_box.connect("toggled", setFont)
	
	confirm_btn.connect("pressed", confirm_changes)
	cancel_btn.connect("pressed", cancel_pressed)
	reset_btn.connect("pressed", reset_values)
	_setValuesInMenu()
	#_HideMenu()

func setFont(toggled: bool):
	#var fontChoice = Settings.FONTS.PIXELATED if toggled else Settings.FONTS.SYSTEM
	#Settings.ChangeFont(fontChoice)
	pass

func reset_values() -> void:
	var canMakeNew = true
	confirm_box.show()
	confirm_box._setText("This will reset all settings.\n[font_size=8]Saves automatically after.")
	canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: confirm_box.hide(); return
	Settings._setBaseValues()
	_setValuesInMenu()
	FM.SaveGame()
	confirm_box.hide();

func _setValuesInMenu() -> void:
	master_volume_slider.value = Settings.settings_dict["master"]
	music_volume_slider.value = Settings.settings_dict["music"]
	BGMusic.loadedLevel = Settings.settings_dict["music"]
	sound_volume_slider.value = Settings.settings_dict["sound"]
	particel_check_box.button_pressed = Settings.settings_dict["particles"]
	font_check_box.button_pressed = true if Settings.settings_dict["font"] == Settings.FONTS.PIXELATED else false
	SetAudio()

func _ShowMenu() -> void:
	_setValuesInMenu()
	show()

func _HideMenu():
	hide()

func SetAudio() -> void:
	Settings.SetValue("master", master_volume_slider.value)
	SM._set_audio_volume_on_bus(0, "master")
	Settings.SetValue("music", music_volume_slider.value)
	SM._set_audio_volume_on_bus(1, "music")
	Settings.SetValue("sound", sound_volume_slider.value)
	SM._set_audio_volume_on_bus(2, "sound")

func confirm_changes() -> void:
	var canMakeNew = true
	confirm_box.show()
	confirm_box._setText("Save changes made?")
	canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: confirm_box.hide(); return
	confirm_box.hide();
	
	SetAudio()
	
	Settings.SetValue("particles", particel_check_box.button_pressed)
	
	#var fontChoice = Settings.FONTS.PIXELATED if font_check_box.button_pressed else Settings.FONTS.SYSTEM
	#Settings.ChangeFont(fontChoice)
	
	FM.SaveGame()
	_HideMenu()

func cancel_pressed() -> void:
	_HideMenu()
	pass
