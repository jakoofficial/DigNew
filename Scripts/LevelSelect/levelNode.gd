extends VBoxContainer
@onready var level_img: TextureRect = $LevelImg
@onready var level_name: RichTextLabel = $LevelImg/LevelName
@onready var go_dig_btn: TextureButton = $GoDigBtn
@onready var locked: Node2D = $Locked
@onready var level_artifacts: HBoxContainer = $Node2D/LevelArtifacts
@onready var entry_cost_back_piece: NinePatchRect = $Node2D/EntryCostBackPiece
@onready var entry_cost_label: RichTextLabel = $Node2D/EntryCostBackPiece/HBoxContainer/EntryCostLabel
@onready var collector_icon: TextureRect = $Node2D/CollectorIcon

@export var LevelName: String = "Level"
@export var GoToLevel: GM.Scenes
@export var LevelTexture: Texture
@export var Locked: bool = true
@export var LevelSize: Vector2 = Vector2(3,3)
@export var levelEntryFee: int = 0

var levelDiscount: int = 0

var level_idx: int = 0
var artifactCollectedCount = 0
func _ready() -> void:
	entry_cost_back_piece.hide()
	level_img.texture = LevelTexture
	level_name.text = LevelName.replace("_", " ")
	go_dig_btn.connect("pressed", _levelPressed)
	levelEntryFee = SetDiscount()
	entry_cost_label.text = str("%s" % levelEntryFee)
	
	if GM.Artifacts.has(LevelName):
		var idx: int = 0
		for i in GM.Artifacts[LevelName]:
			level_artifacts.get_children()[idx].texture = ArtifactInfo.get_artifact(i)._ArtifactLevelIcon
			if ArtifactInfo.get_artifact(i)._HasBeenCollected: 
				level_artifacts.get_children()[idx].modulate = Color.WHITE
				artifactCollectedCount += 1
			else: level_artifacts.get_children()[idx].modulate = Color.BLACK
			idx+=1
	
	if artifactCollectedCount >= 3:
		collector_icon.show()
	else: collector_icon.hide()
	
	if !GM.LevelSelectDict.has(LevelName):
		GM.LevelSelectDict[LevelName] = Locked
	if !GM.LevelSelectDict[LevelName]:
		level_img.modulate.a = 1
		locked.hide()
		entry_cost_back_piece.show()
		if PS._PBalance < levelEntryFee:
			go_dig_btn.disabled = true
		else:
			go_dig_btn.disabled = false
		if GM.canFindArtifacts and GM.artifactChance > 0:
			level_artifacts.show()
		else: level_artifacts.hide()
	else:
		level_img.modulate.a = 0.5
		locked.show()
		entry_cost_back_piece.hide()
		go_dig_btn.disabled = true
		level_artifacts.hide()

func SetDiscount() -> int:
	var perc: float = float(PS._LevelDiscount)/100.0
	return levelEntryFee - roundi(levelEntryFee * perc)

func _levelPressed() -> void:
	if !GM.LevelSelectDict[LevelName]:
		if PS._PBalance < levelEntryFee: return
		
		PS._PBalance -= levelEntryFee
		GM.currDigType = LevelName
		GM.xSpots = LevelSize.x
		GM.ySpots = LevelSize.y
		GM.currLevelDigFee = levelEntryFee
		GM.load_scene(GoToLevel, 1.0)
