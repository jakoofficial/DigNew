extends CanvasLayer
@onready var go_dig_btn: TextureButton = $Skilltree/GoDigBtn
@onready var skills: Node2D = $"../Skills"
@onready var player_balance: RichTextLabel = $Skilltree/HBoxContainer/PlayerBalance

func _ready() -> void:
	go_dig_btn.connect("pressed", _GoDig)

func _process(delta: float) -> void:
	if player_balance.text != str(PS._PBalance):
		player_balance.text = str(PS._PBalance)

func _GoDig() -> void:
	GM.load_scene(GM.Scenes.DIGAREA)
