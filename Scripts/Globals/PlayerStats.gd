extends Node

# Dig specifics
var _PStrength: int = 1
var _PStaminaCurr: int = 4
var _PStaminaMax: int = 4

var _PBalance: int = 0
var _PValueBonus: int = 0
var _PDigGridAmount: int = 1
var _last_time_played: Dictionary
var _LevelDiscount: int = 0

#Time played
var _PlayedTime: String = "00:00:00" # HH:MM:SS
var seconds: float = 0
var minutes: int = 0
var hours: int = 0
var timePassed: float = 0.0

func _process(delta: float) -> void:
	if GM.LoadedGame:
		timePassed += delta
		
		seconds = int(timePassed)%60
		minutes = int(timePassed/60)%60
		hours = timePassed/3600
		
		_PlayedTime = str("%02d:%02d:%02d" % [hours, minutes, seconds])

func Apply_Upgrade(upgrade: SkillRes.TYPE, amount: float, leveltypeunlock: String = "") -> void:
	match upgrade:
		SkillRes.TYPE.Stamina: 				_PStaminaMax += amount
		SkillRes.TYPE.Strength: 			_PStrength += amount
		SkillRes.TYPE.ValueBonus: 			_PValueBonus += amount
		SkillRes.TYPE.LevelType: 			GM.LevelSelectDict[leveltypeunlock] = false
		SkillRes.TYPE.ArtifactChance: 		GM.artifactChance += amount; GM.canFindArtifacts = true
		SkillRes.TYPE.ArtifactValue: 		GM.artifactBonusPercent += amount
		SkillRes.TYPE.LevelDiscountValue:	_LevelDiscount += amount
	pass

func BaseValues() -> void:
	_PStrength 				= 1
	_PStaminaCurr 			= 4
	_PStaminaMax 			= 4
	_PBalance 				= 0
	_PValueBonus 			= 0
	_PDigGridAmount			= 2
	_LevelDiscount			= 0
	timePassed 				= 0.0
	GM.xSpots 				= 3
	GM.ySpots 				= 3
	GM.canFindArtifacts 	= false
	GM.artifactChance 		= 0
	GM.artifactBonusPercent = 1.0
	
	for l in GM.LevelSelectDict.keys(): GM.LevelSelectDict[l] = true
	
	SkillTreeInfo._Generate()
	ArtifactInfo._generate()

func SetValues(data: Dictionary) -> void:
	_PStrength 				= data["Strength"]
	_PStaminaMax 			= data["StaminaMax"]
	_PBalance 				= data["Balance"]
	_PValueBonus 			= data["ValueBonus"]
	_PDigGridAmount			= data["DigGridAmount"]
	_LevelDiscount			= data["LevelDiscountValue"]
	timePassed				= data["TimePassed"]
	GM.xSpots 				= data["MaxSpotsX"]
	GM.ySpots 				= data["MaxSpotsY"]
	GM.canFindArtifacts 	= data["ArtifactPermit"]
	GM.artifactChance 		= data["ArtifactChance"]
	GM.artifactBonusPercent = data["ArtifactBonusPercent"]
	GM.LevelSelectDict 		= data["LevelSelection"]
	ArtifactInfo.Load(		data["ArtifactCollection"] as Array[ArtifactRes])
	SkillTreeInfo.Load(		data["Skills"] as Array[SkillRes])
	Settings._Load(			data["Settings"] as Dictionary)
