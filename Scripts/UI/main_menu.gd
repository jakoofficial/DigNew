extends Control
@onready var start_game: TextureButton = $StartGame

func _ready() -> void:
	SceneManager.set_loading_screen("res://Scenes/Loading/my_load.tscn", LoadingScreen.Type.DEFAULT)
	start_game.connect("pressed", GM.load_scene.bind(GM.Scenes.SKILLTREE))
