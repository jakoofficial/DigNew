extends Area2D
@onready var hover_info: Control = $HoverInfo
@export var Skill_Name: String = ""
@onready var skill_icon: Sprite2D = $SkillIcon

var skill_res: SkillRes

var hovered: bool = false

func _ready() -> void:
	hide()
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	SkillTreeInfo.AddSkillNodeRef(Skill_Name, self)
	skill_res = (SkillTreeInfo as STI).GetSkill(Skill_Name)
	skill_icon.texture = skill_res._Icon

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	$Sprite2D.frame = 1
	hover_info.hide()

func _draw() -> void:
	if skill_res._LevelCurr >= skill_res._UnlockRequirementAmount:
		for i in skill_res._Unlocks:
			draw_line(Vector2.ZERO, SkillTreeInfo.GetSkillNode(i).global_position - global_position, Color.WHEAT, 2.0)

func _Activate() -> void:
	if skill_res._LevelCurr == skill_res._LevelMaxAmount: return
	
	if PS._PBalance >= skill_res._Cost:
		PS._PBalance -= skill_res._Cost
		skill_res._LevelCurr += 1
		PS.Apply_Upgrade(skill_res._UpgradeType, skill_res._UpgradeAmount)
		if skill_res._LevelCurr >= skill_res._LevelMaxAmount and !skill_res._Finished:
			skill_res._Finished = true
		hover_info._setInfo()
	pass

func _process(delta: float) -> void:
	queue_redraw()
	if !skill_res.is_unlocked: hide(); return
	else: show()
	
	if skill_res._Finished: 
		$Sprite2D.frame = 2
		skill_icon.self_modulate.a = 0.5
	
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
		
	if hovered and FK.JustReleased(AM.action("L_Click")): 
		_Activate()
