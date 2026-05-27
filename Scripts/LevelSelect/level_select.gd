extends Control
@onready var level_container: FlowContainer = $LevelContainer
@onready var back: TextureButton = $Back
@onready var balance_label: RichTextLabel = $PlayerBalance/HBoxContainer/BalanceLabel

func _ready() -> void:
	back.connect("pressed", GM.load_scene.bind(GM.Scenes.SKILLTREE))
	balance_label.text = str("%s" % PS._PBalance)
