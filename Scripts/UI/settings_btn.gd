extends TextureButton

func _ready() -> void:
	connect("pressed", showMenu)
	
func showMenu() -> void:
	if GM.settingsMenu != null and GM.settingsMenu.visible != true:
		GM.settingsMenu._ShowMenu()
	elif GM.settingsMenu.visible:
		GM.settingsMenu.confirm_changes()

func _process(delta: float) -> void:
	if GM.settingsMenu.visible and FK.JustPressed(AM.action("DigOver")):
		GM.settingsMenu.confirm_changes()
