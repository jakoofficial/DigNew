extends Control

@onready var resume: TextureButton = $NinePatchRect/VBoxContainer/Resume
@onready var options: TextureButton = $NinePatchRect/VBoxContainer/Options
@onready var town: TextureButton = $NinePatchRect/VBoxContainer/Town
@onready var confirm_box: Control = $ConfirmBox

func _ready() -> void:
	GM.PauseMenu = self
	resume.connect("button_up", ResumeBtn)
	options.connect("pressed", OptionsBtn)
	town.connect("button_up", TownBtn)

func _process(delta: float) -> void:
	if !GM.paused: hide()
	else: 
		show()

func ResumeBtn() -> void:
	GM.paused = false
	get_tree().paused = GM.paused
	await get_tree().create_timer(0.25).timeout
	GM.afterPauseNotDone = false

func OptionsBtn() -> void:
	pass

func TownBtn() -> void:
	var canMakeNew = true
	if FM.CheckSaveGame():
		confirm_box.show()
		confirm_box.prev_btn = town
		confirm_box._setText("Ending dig early will not refund the trip?")
		canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: return
	
	await PS.add_to_global_inv(GM.curUI.backpack.inventory)
	pass
