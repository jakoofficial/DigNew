extends Control
@onready var skill_node: SkillBase = $".."

@onready var upgrade_name: RichTextLabel = $HoverPanel/VBoxContainer/HBoxContainer/UpgradeName
@onready var upgrade_cost: RichTextLabel = $HoverPanel/VBoxContainer/HBoxContainer/UpgradeCost
@onready var upgrade_desc: RichTextLabel = $HoverPanel/VBoxContainer/UpgradeDesc
@onready var upgrade_change: RichTextLabel = $HoverPanel/VBoxContainer/UpgradeChange

func _ready() -> void:
	hide()
	_setInfo()

func _setInfo() -> void:
	upgrade_name.text = str("%s (%s/%s)" % [skill_node._Name, skill_node._LevelCurr, skill_node._LevelMaxAmount])
	upgrade_cost.text = str(skill_node._Cost)
	upgrade_desc.text = str(skill_node._Description)
	#upgrade_change.text = str(skill_node.)
