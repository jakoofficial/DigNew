extends CanvasLayer

@onready var stamina: ProgressBar = $Control/Stamina

func _ready() -> void:
	GM.currUI = self
	stamina.max_value = PS._PStaminaMax
	stamina.value = PS._PStaminaCurr

func ResetUI() -> void:
	stamina.value = PS._PStaminaMax

func UpdateUI() -> void:
	stamina.value = PS._PStaminaCurr
