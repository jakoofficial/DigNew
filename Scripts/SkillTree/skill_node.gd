extends Area2D
@onready var hover_info: Control = $HoverInfo
@export var Skill_Name: String = ""
@onready var skill_icon: Sprite2D = $SkillIcon
@onready var click_sound: AudioStreamPlayer2D = $ClickSound

var currPar: Node2D
var skill_res: SkillRes

var hovered: bool = false

func _ready() -> void:
	hide()
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	SkillTreeInfo.AddSkillNodeRef(Skill_Name, self)
	skill_res = (SkillTreeInfo as STI).GetSkill(Skill_Name)
	skill_icon.texture = skill_res._Icon
	skill_res._Cost = skill_res._BaseCost
	currPar = $"../.."
	print(currPar)

var tween: Tween
func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	$Sprite2D.frame = 1
	hover_info.hide()

func _Activate() -> void:
	if skill_res._LevelCurr == skill_res._LevelMaxAmount: return
	if PS._PBalance >= skill_res._Cost:
		if !click_sound.playing: click_sound.stop()
		click_sound.pitch_scale = randf_range(0.75, 1.0)
		click_sound.play()
		PS._PBalance -= skill_res._Cost
		skill_res._LevelCurr += 1
		PS.Apply_Upgrade(skill_res._UpgradeType, skill_res._UpgradeAmount, skill_res._LevelTypeUnlock)
		if skill_res._LevelCurr >= skill_res._LevelMaxAmount and !skill_res._Finished:
			skill_res._Finished = true
		skill_res._Cost = ceil(skill_res._BaseCost * pow(skill_res._Multiplier,skill_res._LevelCurr))
		hover_info._setInfo()
		currPar.setStats()
		FM.SaveGame()
	pass

func _process(delta: float) -> void:
	queue_redraw()
	if !skill_res.is_unlocked: hide(); return
	else: show()
	
	if skill_res._Finished: 
		$Sprite2D.frame = 2
		skill_icon.self_modulate.a = 0.5
		$HoverInfo/HoverPanel/VBoxContainer/HBoxContainer/UpgradeCost.hide()
		$HoverInfo/HoverPanel/VBoxContainer/HBoxContainer/TextureRect.hide()
	
	if !skill_res._Finished and !hovered:
		if PS._PBalance < skill_res._Cost: $Sprite2D.frame = 5
		else: $Sprite2D.frame = 4
	
	if skill_res._UnlockRequirementAmount <= skill_res._LevelCurr:
		if skill_res._Unlocks.size() > 0:
			for i in skill_res._Unlocks:
				(SkillTreeInfo as STI).GetSkill(i).is_unlocked = true
	
	if hovered and Input.get_current_cursor_shape() != Input.CURSOR_POINTING_HAND:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if !skill_res._Finished:
			$Sprite2D.frame = 3
		hover_info.show()
		hover_info._setInfo()
		
	
	FK.JustPressed(AM.action("L_Click")) #Remove when fixed
	if hovered and FK.JustPressed(AM.action("L_Click")):
		_Activate()
