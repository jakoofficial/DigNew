extends Node

var audio_stream

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, Settings.settings_dict["master"])
	AudioServer.set_bus_volume_db(1, Settings.settings_dict["music"])
	AudioServer.set_bus_volume_db(2, Settings.settings_dict["sound"])

func _set_audio_volume_on_bus(bus:int, setting:String):
	AudioServer.set_bus_volume_db(bus, Settings.settings_dict[setting])

func _mute_bus(bus: int = 0, enabled: bool = true):
	AudioServer.set_bus_mute(bus, enabled)
