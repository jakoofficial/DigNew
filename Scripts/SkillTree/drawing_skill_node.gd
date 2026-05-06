extends Node2D

@onready var par: Area2D = $".."

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if par.skill_res._LevelCurr >= par.skill_res._UnlockRequirementAmount:
		for i in par.skill_res._Unlocks:
			draw_line(Vector2.ZERO, SkillTreeInfo.GetSkillNode(i).global_position - global_position, Color.WHEAT, 2.0)
