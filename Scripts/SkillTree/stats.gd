extends Control

@onready var block_value: RichTextLabel = $VBoxContainer/BlockValue/Value
@onready var damage_value: RichTextLabel = $VBoxContainer/Damage/Value
@onready var stamina_value: RichTextLabel = $VBoxContainer/Stamina/Value
@onready var chance_value: RichTextLabel = $VBoxContainer/ArtifactChance/Value
@onready var artifact_value: RichTextLabel = $VBoxContainer/ArtifactValue/Value

func _ready() -> void:
	SetStat()
	pass

func SetStat() -> void:
	block_value.text = str("+%s" % PS._PValueBonus)
	damage_value.text = str("%s" % PS._PStrength)
	stamina_value.text = str("%s" % PS._PStaminaMax)
	chance_value.text = str("%s" % GM.artifactChance) + str("%")
	artifact_value.text = str("+%s" % GM.artifactBonusPercent) + str("%")
