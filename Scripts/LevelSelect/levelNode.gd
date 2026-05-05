extends VBoxContainer
@onready var level_img: TextureRect = $LevelImg
@onready var level_name: RichTextLabel = $LevelImg/LevelName
@onready var go_dig_btn: TextureButton = $GoDigBtn
@onready var locked: Node2D = $Locked

@export var LevelName: String = "Level"
@export var GoToLevel: GM.Scenes
@export var LevelTexture: Texture
@export var Locked: bool = true

func _ready() -> void:
	level_img.texture = LevelTexture
	level_name.text = LevelName
	go_dig_btn.connect("pressed", _levelPressed)
	
	if !GM.LevelSelectDict.has(LevelName):
		GM.LevelSelectDict[LevelName] = Locked
	if !GM.LevelSelectDict[LevelName]:
		level_img.modulate.a = 1
		locked.hide()
		go_dig_btn.disabled = false
	else:
		level_img.modulate.a = 0.5
		locked.show()
		go_dig_btn.disabled = true


func _levelPressed() -> void:
	if !GM.LevelSelectDict[LevelName]:
		GM.currDigType = LevelName
		GM.load_scene(GoToLevel)
