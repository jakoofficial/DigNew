extends Node

# Dig specifics
var _PStrength: int = 1
var _PStaminaCurr: int = 4
var _PStaminaMax: int = 4

var _PBalance: int = 0

func Apply_Upgrade(upgrade: SkillRes.TYPE, amount: int) -> void:
	match upgrade:
		SkillRes.TYPE.Stamina: _PStaminaMax += amount
		SkillRes.TYPE.Strength: _PStrength += amount
	pass
