extends LoadingScreen

func _get_range_object() -> Object:
	return get_node("ProgressBar")

func _get_tween_duration() -> float:
	return 0.1

func handle_load_error() -> void:
	get_node("MyErrorLabel").text = "Scene cannot load..."
