extends AudioStreamPlayer

enum AUDIO {
	MainMenu,
	Level1,
	Level2,
} 
var curAudio: AUDIO

var file
func _play_BG_Music(audio:AUDIO) -> void:
	curAudio = audio
	print(curAudio)
	
	match curAudio:
		AUDIO.MainMenu: file = preload("res://Sounds/BGMusic/MAIN_THEME_DREAMY_DASH_LOOP A.wav")
		AUDIO.Level1: file = preload("res://Sounds/BGMusic/Levels/FIRST_STEPS_THEME_LOOP_A.wav")
		AUDIO.Level2: file = preload("res://Sounds/BGMusic/Levels/FIRST_STEPS_THEME_LOOP_B.wav")
	
	stream = file
	play()
	started = true

var started: bool = false
var soundLevel: float = -50
var loadedLevel: float = -20
func _ready() -> void:
	volume_db = soundLevel
	stop()
	finished.connect(SwitchAudio)

func SwitchAudio() -> void:
	if (curAudio == AUDIO.Level1 or curAudio == AUDIO.Level2):
		_play_BG_Music(AUDIO.Level1 if randi_range(0, 1)==0 else AUDIO.Level2)
		return

var fadeOver: bool = false
func _process(delta: float) -> void:
	if !fadeOver and started and soundLevel < loadedLevel:
		soundLevel+=delta * 10
	volume_db = soundLevel - 10
		#print(soundLevel)
	if soundLevel >= loadedLevel: fadeOver = true

func _stop_BG_Music() -> void:
	stop()
	started = false
	
