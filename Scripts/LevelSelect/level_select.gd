extends Control
@onready var level_container: FlowContainer = $LevelContainer
@onready var back: TextureButton = $Back

func _ready() -> void:
	back.connect("pressed", GM.load_scene.bind(GM.Scenes.SKILLTREE))
