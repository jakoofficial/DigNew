extends Control
@onready var text_box: RichTextLabel = $NinePatchRect/TextBox
@onready var cancel: TextureButton = $NinePatchRect/HBoxContainer/Cancel
@onready var confirm: TextureButton = $NinePatchRect/HBoxContainer/Confirm

var prev_btn: TextureButton

var confirmOnly: bool = false

func _ready() -> void:
	_setText()
	
	cancel.connect("pressed", cancel_confirmation)
	confirm.connect("pressed", confirm_confirmation)

func showSpecial(btnText: String = "Confirm") -> void:
	cancel.hide()
	cancel.disabled = true
	confirm.get_child(0).text = str(btnText)
	show()

func resetButtons():
	cancel.show()
	cancel.disabled = false
	confirm.get_child(0).text = str("Confirm")

func _setText(t: String = "TBD"):
	text_box.text = t
	#cancel.grab_focus()

func cancel_confirmation() -> void:
	if prev_btn != null:
		prev_btn.grab_focus()
	confirmResult.emit(false)
	hide()
	pass

signal confirmResult
func confirm_confirmation() -> void:
	confirmResult.emit(true)
	hide()
