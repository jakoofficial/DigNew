extends Node

# Dig specifics
var _PStrength: int = 1
var _PStaminaCurr: int = 4
var _PStaminaMax: int = 4

var _PBalance: int = 0
var _PValueBonus: int = 0

func Apply_Upgrade(upgrade: SkillRes.TYPE, amount: int, leveltypeunlock: String = "") -> void:
	match upgrade:
		SkillRes.TYPE.Stamina: _PStaminaMax += amount
		SkillRes.TYPE.Strength: _PStrength += amount
		SkillRes.TYPE.ValueBonus: _PValueBonus += amount
		SkillRes.TYPE.LevelType: GM.LevelSelectDict[leveltypeunlock] = false
	pass

func SetValues(data: Dictionary) -> void:
	_PStrength = data["Strength"]
	_PStaminaMax = data["StaminaMax"]
	_PBalance = data["Balance"]
	_PValueBonus = data["ValueBonus"]
	GM.xSpots = data["MaxSpotsX"]
	GM.ySpots = data["MaxSpotsY"]
	SkillTreeInfo.Load((data["Skills"] as Array[SkillRes]))
	GM.LevelSelectDict = data["LevelSelection"]
