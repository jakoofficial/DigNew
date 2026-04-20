extends LoadingScreen

@onready var entering: RichTextLabel = $Entering

func _ready() -> void:
	entering.text = str("[font_size=12]Now Entering\n%s" % GM.SceneEntering)

func _get_range_object() -> Object:
	return get_node("ProgressBar")

func _get_tween_duration() -> float:
	return 0.1

func handle_load_error() -> void:
	get_node("MyErrorLabel").text = "Scene cannot load..."
