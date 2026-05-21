extends Node

# Dig specifics
var _PStrength: int = 1
var _PStaminaCurr: int = 4
var _PStaminaMax: int = 4

var _PBalance: int = 100
var _PValueBonus: int = 0

func Apply_Upgrade(upgrade: SkillRes.TYPE, amount: float, leveltypeunlock: String = "") -> void:
	match upgrade:
		SkillRes.TYPE.Stamina: _PStaminaMax += amount
		SkillRes.TYPE.Strength: _PStrength += amount
		SkillRes.TYPE.ValueBonus: _PValueBonus += amount
		SkillRes.TYPE.LevelType: GM.LevelSelectDict[leveltypeunlock] = false
		SkillRes.TYPE.ArtifactChance: GM.artifactChance += amount; GM.canFindArtifacts = true
		SkillRes.TYPE.ArtifactValue: GM.artifactBonusPercent += amount
	pass

func BaseValues() -> void:
	_PStrength 				= 1
	_PStaminaCurr 			= 4
	_PStaminaMax 			= 4
	_PBalance 				= 0
	_PValueBonus 			= 0
	GM.xSpots 				= 3
	GM.ySpots 				= 3
	GM.canFindArtifacts 	= false
	GM.artifactChance 		= 0
	GM.artifactBonusPercent = 1.0
	
	for l in GM.LevelSelectDict.keys(): GM.LevelSelectDict[l] = true
	
	SkillTreeInfo._Generate()
	ArtifactInfo._generate()

func SetValues(data: Dictionary) -> void:
	_PStrength = data["Strength"]
	_PStaminaMax = data["StaminaMax"]
	_PBalance = data["Balance"]
	_PValueBonus = data["ValueBonus"]
	GM.xSpots = data["MaxSpotsX"]
	GM.ySpots = data["MaxSpotsY"]
	GM.canFindArtifacts = data["ArtifactPermit"]
	GM.artifactChance = data["ArtifactChance"]
	GM.artifactBonusPercent = data["ArtifactBonusPercent"]
	ArtifactInfo.Load(data["ArtifactCollection"] as Array[ArtifactRes])
	SkillTreeInfo.Load((data["Skills"] as Array[SkillRes]))
	GM.LevelSelectDict = data["LevelSelection"]
	Settings._Load(data["Settings"] as Dictionary)
