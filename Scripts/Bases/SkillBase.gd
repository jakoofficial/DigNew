@abstract class_name SkillBase
extends Area2D

@export var _Icon: Texture
@export var is_unlocked: bool = false
@export var _Name: String = "Skill"
@export var _Cost: int = 0
@export_multiline() var _Description: String = "Skill description"
@export var _LevelCurr: int = 0
@export var _LevelMaxAmount: int = 1
@export var _Unlocks: Array[SkillBase]
@export var _UnlockRequirementAmount: int = 1
@export var _Finished: bool = false

@abstract
func _Activate() -> void
