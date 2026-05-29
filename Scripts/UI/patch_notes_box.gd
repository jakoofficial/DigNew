extends NinePatchRect

@onready var close_patches: TextureButton = $ClosePatches
@onready var patch_notes_label: RichTextLabel = $ScrollContainer/PatchNotesLabel

var patchTitle = """[font_size=16][center]Patch Notes[/center][/font_size]
[font_size=6][center]%s[/center][/font_size]""" % [GM.Game_Version]

var patchAdded = """
This set of patches are for a early build of the game as development of the project still is udnerway.

Something
	hellow
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
