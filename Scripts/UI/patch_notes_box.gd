extends NinePatchRect

@onready var close_patches: TextureButton = $ClosePatches
@onready var patch_notes_label: RichTextLabel = $ScrollContainer/PatchNotesLabel

var patchTitle = """[font_size=16][center]Patch Notes[/center][/font_size]
[font_size=6][center]%s[/center][/font_size]""" % [GM.Game_Version]

var patchAdded = """[font_size=14]Added[/font_size]
[table=2]
[cell expand][left]Family[/left][/cell][cell][right]Makarov[/right][/cell]
[cell expand][left]TypeWeapon[/left][/cell][cell][right]Pistol[/right][/cell]
[/table]
"""
var patchFixes = """[font_size=14]Fixes[/font_size]"""

var patches: String = """%s
%s

%s

""" % [patchTitle, patchAdded, patchFixes]

func _ready() -> void:
	close_patches.connect("pressed", close)
	patch_notes_label.text = patches

func close() -> void:
	hide()
	pass
