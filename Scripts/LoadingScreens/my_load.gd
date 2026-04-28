extends LoadingScreen
@onready var pickaxe: TextureRect = $Pickaxe


var canPause: bool = false

var tween: Tween
func _ready() -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(pickaxe).set_loops(0).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(pickaxe, "rotation_degrees", -10.0, 0.75)
	tween.chain().tween_property(pickaxe, "rotation_degrees", 45.0, 0.1)

func _exit_tree() -> void:
	tween.kill()

func _get_range_object() -> Object:
	return get_node("ProgressBar")

func _get_tween_duration() -> float:
	return 0.1

func handle_load_error() -> void:
	get_node("MyErrorLabel").text = "Scene cannot load..."
