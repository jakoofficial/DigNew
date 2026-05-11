extends VBoxContainer
@onready var level_img: TextureRect = $LevelImg
@onready var level_name: RichTextLabel = $LevelImg/LevelName
@onready var go_dig_btn: TextureButton = $GoDigBtn
@onready var locked: Node2D = $Locked
@onready var level_artifacts: HBoxContainer = $Node2D/LevelArtifacts

@export var LevelName: String = "Level"
@export var GoToLevel: GM.Scenes
@export var LevelTexture: Texture
@export var Locked: bool = true
@export var LevelSize: Vector2 = Vector2(3,3)

var level_idx: int = 0
func _ready() -> void:
	level_img.texture = LevelTexture
	level_name.text = LevelName.replace("_", " ")
	go_dig_btn.connect("pressed", _levelPressed)
	
	if GM.Artifacts.has(LevelName):
		var idx: int = 0
		for i in GM.Artifacts[LevelName]:
			level_artifacts.get_children()[idx].texture = ArtifactInfo.get_artifact(i)._ArtifactLevelIcon
			idx+=1
	
	if !GM.LevelSelectDict.has(LevelName):
		GM.LevelSelectDict[LevelName] = Locked
	if !GM.LevelSelectDict[LevelName]:
		level_img.modulate.a = 1
		locked.hide()
		go_dig_btn.disabled = false
		if GM.canFindArtifacts and GM.artifactChance > 0:
			level_artifacts.show()
		else: level_artifacts.hide()
	else:
		level_img.modulate.a = 0.5
		locked.show()
		go_dig_btn.disabled = true
		level_artifacts.hide()

func _levelPressed() -> void:
	if !GM.LevelSelectDict[LevelName]:
		GM.currDigType = LevelName
		GM.xSpots = LevelSize.x
		GM.ySpots = LevelSize.y
		GM.load_scene(GoToLevel)
