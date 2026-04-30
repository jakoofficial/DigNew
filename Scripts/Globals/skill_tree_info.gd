class_name STI
extends Node2D

@export var Skills: Array[SkillRes]

var SkillDict: Dictionary[String, int]
var SkillNodesDict: Dictionary[String, Area2D]

func GetSkill(skillName: String) -> SkillRes:
	return Skills[SkillDict[skillName]]

func GetSkillNode(skillName: String) -> Area2D:
	if !SkillNodesDict.has(skillName): return null
	return SkillNodesDict[skillName]

func AddSkillNodeRef(skillName: String, node: Area2D) -> void:
	SkillNodesDict[skillName] = node

func _ready() -> void:
	var i = 0;
	for s in Skills:
		SkillDict[s._Name] = i
		i += 1
