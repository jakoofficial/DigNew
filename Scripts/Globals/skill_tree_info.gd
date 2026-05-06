class_name STI
extends Node2D

@export var Skills: Array[SkillRes]

var skillsArrCopy: Array[SkillRes]

var SkillDict: Dictionary[String, int]
var SkillNodesDict: Dictionary[String, Area2D]

func GetSkill(skillName: String) -> SkillRes:
	return skillsArrCopy[SkillDict[skillName]]

func GetSkillNode(skillName: String) -> Area2D:
	if !SkillNodesDict.has(skillName): return null
	return SkillNodesDict[skillName]

func AddSkillNodeRef(skillName: String, node: Area2D) -> void:
	SkillNodesDict[skillName] = node

func _ready() -> void:
	_Generate()

func _Generate() -> void:
	skillsArrCopy = Skills.duplicate_deep()
	
	var i = 0;
	SkillDict.clear()
	for s in skillsArrCopy:
		SkillDict[s._Name] = i
		i += 1

func Load(savedSkills: Array[SkillRes]) -> void:
	_Generate()
	skillsArrCopy = savedSkills
