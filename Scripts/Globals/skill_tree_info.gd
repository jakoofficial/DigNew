class_name STI
extends Node2D

@export var Skills: Array[SkillRes]

var SkillDict: Dictionary[String, int]

func GetSkill(skillName: String) -> SkillRes:
	return Skills[SkillDict[skillName]]

func _ready() -> void:
	var i = 0;
	for s in Skills:
		SkillDict[s._Name] = i
		i += 1
