extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var thanks: VBoxContainer = $Thanks
@onready var back: RichTextLabel = $Back

const CREDIT_ITEM = preload("uid://lxwjqqp8u2ok")

var artistName: String
var artTitle: String

var credits: Dictionary[String, Array] = {
	"GameDev Market - Music": ["Main Theme Dreamy Dash loop A", "First Steps Theme Loop A-B", "End Credits Track"],
	"Sound Effects": ["TomWinandySFX", "Quiz & Puzzle Musical SFX (GameDev Market)"],
	"Scene Manager Addon": ["mcanton"],
	"BoldByte": [
		"Programmer: Jay",
		"Art: Jay"],
	"Game Engine": ["Godot v4.6"],
	"Fonts": ["Pixelated", "Roboto"]
}

var cred: Array
var music: AudioStreamPlayer
var music10percLeft: float
func _ready() -> void:
	music = BGMusic
	music10percLeft = music.stream.get_length() * 0.10
	
	thanks.modulate.a8 = 0
	back.modulate.a8 = 0
	for c in credits.keys():
		var item = CREDIT_ITEM.instantiate()
		item.get_child(3).hide()
		item.get_child(2).custom_minimum_size = Vector2(0, 15)
		item.get_child(0).text = c
		for i in credits[c]:
			item.get_child(1).text += str("%s\n" % i)
		v_box_container.add_child(item)
		item.modulate.a8 = 0
		cred.append(item)

var finished: bool = false
var fadeBegan: bool = false
func _process(delta: float) -> void:
	if FK.JustPressed(AM.action("SkipIntro")) and !finished:
		for i in cred:
			i.modulate.a8 = 255
		thanks.modulate.a8 = 255
		back.modulate.a8 = 255
		finished = true
	if music.get_playback_position() >= (music.stream.get_length()-music10percLeft) or (!fadeBegan and FK.JustPressed(AM.action("SkipIntro")) and finished):
		fadeBegan = true
	
	if fadeBegan and $Fade.modulate.a8 < 255: 
		$Fade.modulate.a8 += delta * 60
	elif $Fade.modulate.a8 == 255:
		GM.load_scene(GM.Scenes.MAINMENU)
	
	if !finished:
		for i in cred:
			if i.modulate.a8 < 255: i.modulate.a8 += delta * 60
			await get_tree().create_timer(1.0).timeout
		if thanks.modulate.a8 < 255: thanks.modulate.a8 += delta * 60
		if back.modulate.a8 < 255: back.modulate.a8 += delta * 60
		elif back.modulate.a8 == 255: finished = true
