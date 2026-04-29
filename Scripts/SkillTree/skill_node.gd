extends SkillBase
@onready var hover_info: Control = $HoverInfo

var hovered: bool = false
func _ready() -> void:
	hide()
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover_info.hide()

func _Activate() -> void:
	if _LevelCurr == _LevelMaxAmount: return
	
	if PS._PBalance >= _Cost:
		PS._PBalance -= _Cost
		_LevelCurr += 1
		hover_info._setInfo()
	pass

func _process(delta: float) -> void:
	if !is_unlocked: hide(); return
	else: show()
	
	if _UnlockRequirementAmount <= _LevelCurr:
		if _Unlocks.size() > 0:
			for i in _Unlocks:
				i.is_unlocked = true
	
	if hovered and Input.get_current_cursor_shape() != Input.CURSOR_POINTING_HAND:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		hover_info.show()
		hover_info._setInfo()
		
	if hovered and FK.JustReleased(AM.action("L_Click")): 
		print("asd")
		_Activate()
