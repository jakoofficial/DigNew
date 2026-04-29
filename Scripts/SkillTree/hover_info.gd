extends Control
@onready var skill_node: Area2D = $".."

@onready var upgrade_name: RichTextLabel = $HoverPanel/VBoxContainer/HBoxContainer/UpgradeName
@onready var upgrade_cost: RichTextLabel = $HoverPanel/VBoxContainer/HBoxContainer/UpgradeCost
@onready var upgrade_desc: RichTextLabel = $HoverPanel/VBoxContainer/UpgradeDesc
@onready var upgrade_change: RichTextLabel = $HoverPanel/VBoxContainer/UpgradeChange

func _ready() -> void:
	hide()
	#_setInfo()

func _setInfo() -> void:
	upgrade_name.text = str("%s (%s/%s)" % [skill_node.skill_res._Name, skill_node.skill_res._LevelCurr, skill_node.skill_res._LevelMaxAmount])
	upgrade_cost.text = str(skill_node.skill_res._Cost)
	upgrade_desc.text = str(skill_node.skill_res._Description)
	#upgrade_change.text = str(skill_node.)
