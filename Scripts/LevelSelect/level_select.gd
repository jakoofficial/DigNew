extends Control
@onready var level_container: FlowContainer = $LevelContainer
@onready var back: TextureButton = $Back
@onready var balance_label: RichTextLabel = $PlayerBalance/HBoxContainer/BalanceLabel
@onready var end_btn: TextureButton = $EndBtn
@onready var confirm_box: Control = $ConfirmBox

var allCollected: bool = true
func _ready() -> void:
	back.connect("pressed", GM.load_scene.bind(GM.Scenes.SKILLTREE))
	end_btn.connect("pressed", end_btn_pressed)
	balance_label.text = str("%s" % PS._PBalance)
	
	for i:ArtifactRes in ArtifactInfo.Artifacts_Copy:
		if !i._HasBeenCollected: allCollected = false; break
	
	if !allCollected:
		end_btn.disabled = true
		$EndBtn/BG.self_modulate = Color.from_rgba8(82, 82, 82, 255)
		$EndBtn/BG/EndBtnText.text = str("? ? ?")
	else:
		end_btn.disabled = false
		$EndBtn/BG.self_modulate = Color.from_rgba8(255, 255, 255, 255)
		$EndBtn/BG/EndBtnText.text = str("End?")


func end_btn_pressed() -> void:
	var canMakeNew = true
	confirm_box.show()
	confirm_box._setText("This will end the game.\nYou will be able to continue this save.\n\nContinue?")
	canMakeNew = await confirm_box.confirmResult
	if !canMakeNew: return
	
	BGMusic.Fade = BGMusic.FADE.OutIn
	await BGMusic.FadeFinished
	BGMusic._play_BG_Music(BGMusic.AUDIO.End)
	
	GM.load_scene(GM.Scenes.END)
	pass
