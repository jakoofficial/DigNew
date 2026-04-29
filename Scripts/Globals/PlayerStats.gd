extends Node

# Dig specifics
var _PStrength: int = 1
var _PStaminaCurr: int = 4
var _PStaminaMax: int = 4

var _PBalance: int = 0

var SkillsBought: Dictionary[String, SkillBase]

func AddSkill(skill:SkillBase) -> void:
	SkillsBought[skill._Name] = skill
