extends Node2D

@onready var spots: Node2D = $Spots
@onready var dig_spot: Area2D = $DigSpot
@onready var cursor: Sprite2D = $Cursor
@onready var gui: CanvasLayer = $GUI
@onready var artifact_gotten: Node2D = $Artifact

var vSize: Vector2
var LevelName: String
var inventory: Dictionary[DigSpot, int]
var artifact_inv: Dictionary[ArtifactRes, int]

func _ready() -> void:
	GM.currDigArea = self
	GM.digDone = false
	PS._PStaminaCurr = PS._PStaminaMax
	LevelName = GM.currDigType
	gui.ResetUI()
	inventory.clear()
	setCursor.connect(setCursorPos)
	vSize = get_viewport_rect().size
	
	#Setting the dig type
	if GM.digspotTypes.has(GM.currDigType):
		var temp = GM.digspotTypes.get(GM.currDigType)
		dig_spot._Name = temp[0]
		dig_spot._SpriteFrame = temp[1]
		dig_spot._Health = temp[2]
		dig_spot._Value = temp[3]
		if GM.digSounds[temp[0]] != null:
			dig_spot._Sounds = GM.digSounds[temp[0]]
	Generate()

func _process(delta: float) -> void:
	if GM.digspotHover: cursor.show()
	else: cursor.hide()
	
	##GM.digReady and 
	#if spotsLeft <= 0:
		#GM.digDone = true
		#gui._EndDigPressed()
	
	if $Node2D/BackParticles.emitting != Settings.settings_dict["particles"]:
		$Node2D/BackParticles.emitting = Settings.settings_dict["particles"]
		$Node2D/BackParticles.visible = Settings.settings_dict["particles"]

func addToInv(collected: DigSpot) -> void:
	for i in inventory.keys():
		if i._Name == collected._Name:
			inventory[i] += 1
			return
	var newitem: DigSpot
	newitem = collected.duplicate()
	inventory[newitem] = 1
	collected = null

func addArtifactToInv(collected: ArtifactRes) -> void:
	for i in artifact_inv.keys():
		if i._Name == collected._Name:
			artifact_inv[i] += 1
			return
	var newitem: ArtifactRes
	newitem = collected.duplicate()
	artifact_inv[newitem] = 1
	collected = null

signal setCursor
func setCursorPos(pos = Vector2.ZERO) -> void:
	if pos == Vector2.ZERO: pos = Vector2(-500, -500)
	cursor.global_position = pos

func reset_dig() -> void:
	GM.digDone = false
	GM.digReady = false
	PS._PStaminaCurr = PS._PStaminaMax
	inventory.clear()
	artifact_inv.clear()
	gui.ResetUI()
	artifactAdded = 0
	if spots.get_child_count() > 0:
		for c in spots.get_children():
			c.reparent(get_tree().root)
			c.call_deferred("queue_free")
	Generate()

var artifactAdded: int = 0
var rng = RandomNumberGenerator.new()
func set_artifact() -> String:
	if GM.artifactAmountAllowed <= artifactAdded or GM.artifactChance <= 0: return ""
	var chance: int = GM.artifactChance
	var rngSum = rng.randi_range(0, 100)
	if rngSum > chance: return ""
	
	var artifactRng: int = rng.randi_range(0,2)
	if GM.Artifacts.has(LevelName):
		var idx: int = 0
		for i in GM.Artifacts[LevelName]:
			if idx == artifactRng:
				artifactAdded+=1
				return i
			idx+=1
	return ""

func Generate() -> void:
	GM.digReady = false
	var spacing = 2       # Spacing between spots
	var spotSize = 64     # Size of each spot (64x64)
	var pivot_offset = spotSize / 2 # Offset of the size of the spot

	# Calculate the total width and height of the grid, including spacing
	var totalWidth = (GM.xSpots * spotSize) + ((GM.xSpots - 1) * spacing)
	var totalHeight = (GM.ySpots * spotSize) + ((GM.ySpots - 1) * spacing)

	# Calculate the starting position to center the grid in the viewport
	var spawnStartX = (vSize.x - totalWidth) / 2
	var spawnStartY = (vSize.y - totalHeight) / 2
	
	var artifact_spawn: String = set_artifact()
	var artifact_spawn_at: int = 0
	var spawnIdx: int = 1
	
	if artifact_spawn != "":
		artifact_spawn_at = rng.randi_range(0, (GM.ySpots+GM.xSpots))
	
	for y in range(GM.ySpots):
		for x in range(GM.xSpots):
			var spot: DigSpot = dig_spot.duplicate()
			spot.area = self
			spot._Value += PS._PValueBonus
			if artifact_spawn_at == spawnIdx:
				spot.artifact = artifact_spawn
			spots.add_child(spot)
			GM.digSpotsLeft+=1
			spot.digZone = self
			spot.hide()
			# Position each spot with spacing
			spot.global_position.x = spawnStartX + (x * (spotSize + spacing))+pivot_offset
			spot.global_position.y = spawnStartY + (y * (spotSize + spacing))+pivot_offset
			spawnIdx += 1
		spawnIdx += 1
	
	var time: float = 1.0
	if spots.get_child_count() > 0:
		for c in spots.get_children():
			c.show()
			c.Spawn()
			await get_tree().create_timer(time/(GM.xSpots*GM.ySpots)).timeout
		
	GM.digReady = true
