extends Node

var audio_stream

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, Settings.settings_dict["master"])
	AudioServer.set_bus_volume_db(1, Settings.settings_dict["music"])
	AudioServer.set_bus_volume_db(2, Settings.settings_dict["sound"])

func _set_audio_volume_on_bus(bus:int, setting:String):
	AudioServer.set_bus_volume_db(bus, Settings.settings_dict[setting])
	_mute_bus(bus, false)
	BGMusic.stream_paused = false
	if Settings.settings_dict[setting] == -20:
		_mute_bus(bus, true)
		BGMusic.stream_paused = true

func _mute_bus(bus: int, enabled: bool = true):
	AudioServer.set_bus_mute(bus, enabled)
