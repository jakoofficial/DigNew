extends Node

var audio_stream

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(Settings.settings_dict["master"]))
	AudioServer.set_bus_volume_db(1, linear_to_db(Settings.settings_dict["music"]))
	AudioServer.set_bus_volume_db(2, linear_to_db(Settings.settings_dict["sound"]))

func _set_audio_volume_on_bus(bus:int, setting:String):
	AudioServer.set_bus_volume_db(bus, linear_to_db(Settings.settings_dict[setting]))
