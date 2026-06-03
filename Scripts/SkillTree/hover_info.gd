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
	var res: SkillRes = skill_node.skill_res
	var typeValueCurr: float
	var typeValueNew: float
	var textToWrite: String = ""
	
	upgrade_name.text = str("%s (%s/%s)" % [res._Name.replace("_", " "), res._LevelCurr, res._LevelMaxAmount])
	upgrade_cost.text = str(res._Cost)
	upgrade_desc.text = str(res._Description)
	
	if !res._LevelCurr >= res._LevelMaxAmount:
		match res._UpgradeType:
			res.TYPE.Stamina:
				typeValueCurr = PS._PStaminaMax
				typeValueNew = (PS._PStaminaMax + res._UpgradeAmount)
				textToWrite = str("%s > %s" % [int(typeValueCurr), int(typeValueNew)])
			res.TYPE.Strength:
				typeValueCurr = PS._PStrength
				typeValueNew = (PS._PStrength + res._UpgradeAmount)
				textToWrite = str("%s > %s" % [int(typeValueCurr), int(typeValueNew)])
			res.TYPE.ValueBonus:
				typeValueCurr = PS._PValueBonus
				typeValueNew = (PS._PValueBonus + res._UpgradeAmount)
				textToWrite = str("%s > %s" % [int(typeValueCurr), int(typeValueNew)])
			res.TYPE.LevelType:
				textToWrite = ""
			res.TYPE.ArtifactChance:
				typeValueCurr = GM.artifactChance
				typeValueNew = (GM.artifactChance + res._UpgradeAmount)
				textToWrite = str("%s" % typeValueCurr) + str("> %s" % typeValueNew) 
			res.TYPE.ArtifactValue:
				typeValueCurr = GM.artifactBonusPercent
				typeValueNew = (GM.artifactBonusPercent + res._UpgradeAmount)
				textToWrite = str("%s" % typeValueCurr) + str("> %s" % typeValueNew)
			res.TYPE.LevelDiscountValue:
				typeValueCurr = PS._LevelDiscount
				typeValueNew = (PS._LevelDiscount + res._UpgradeAmount)
				textToWrite = str("%s" % typeValueCurr) + str("> %s" % typeValueNew)
		upgrade_change.text = textToWrite
	else: 
		upgrade_change.text = str("Maxed")
		
