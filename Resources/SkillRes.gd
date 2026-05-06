class_name SkillRes
extends Resource

@export var _Icon: Texture
@export var is_unlocked: bool = false
@export var _Name: String = "Skill"
@export var _Cost: int = 0
@export var _Multiplier: float = 1.15
@export_multiline() var _Description: String = "Skill description"
@export var _LevelCurr: int = 0
@export var _LevelMaxAmount: int = 1
@export var _Unlocks: Array[String]
@export var _UnlockRequirementAmount: int = 1
@export var _Finished: bool = false
@export var _UpgradeType:TYPE = 0
@export var _UpgradeAmount: int = 1
## Only used if Upgrade Type is set to LevelType
@export var _LevelTypeUnlock: String = ""

enum TYPE {
	Stamina,
	Strength,
	ValueBonus,
	LevelType
}
