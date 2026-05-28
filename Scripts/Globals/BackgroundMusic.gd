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
	
	match curAudio:
		AUDIO.MainMenu: file = preload("res://Sounds/BGMusic/MAIN_THEME_DREAMY_DASH_LOOP A.wav")
		AUDIO.Level1: file = preload("res://Sounds/BGMusic/Levels/FIRST_STEPS_THEME_LOOP_A.wav")
		AUDIO.Level2: file = preload("res://Sounds/BGMusic/Levels/FIRST_STEPS_THEME_LOOP_B.wav")
	
	stream = file
	play()
	started = true

var started: bool = false
var soundLevel: float = 0
var loadedLevel: float = 0.25
func _ready() -> void:
	volume_db = linear_to_db(soundLevel)
	finished.connect(SwitchAudio)

func SetMusic():
	if playing and curAudio != AUDIO.MainMenu:
		timeMax = 2.0
		Fade = FADE.OutIn
		await FadeFinished
		_play_BG_Music(AUDIO.MainMenu)
	elif !playing:
		timeMax = 5.0
		Fade = FADE.In
		_play_BG_Music(AUDIO.MainMenu)
		await FadeFinished

var musicStarted: bool = false


func SwitchAudio() -> void:
	if (curAudio == AUDIO.Level1 or curAudio == AUDIO.Level2):
		_play_BG_Music(AUDIO.Level1 if randi_range(0, 1)==0 else AUDIO.Level2)
		return

var time: float = 0.0
var timeMax: float = 5.0

enum FADE {
	None,
	In,
	Out,
	InOut,
	OutIn,
}

func FadeIn(delta:float, halfTime: bool = false) -> bool:
	var newTime: float = timeMax / 2 if halfTime else timeMax
	time += delta
	var newDB = ((time-0.0)/(newTime-0.0))*(loadedLevel-0.0)+0.0
	if newDB >= loadedLevel: volume_db = linear_to_db(loadedLevel); return true
	volume_db = linear_to_db(newDB)
	return false

func FadeOut(delta:float, halfTime: bool = false) -> bool:
	var newTime: float = timeMax / 2 if halfTime else timeMax
	time += delta
	var newDB = ((time-0.0)/(newTime-0.0))*(0.0-loadedLevel)+loadedLevel
	if newDB <= 0.0: volume_db = linear_to_db(0); return true
	volume_db = linear_to_db(newDB)
	
	return false

var Fade: FADE = FADE.None
signal FadeFinished
func _process(delta: float) -> void:
	match Fade:
		FADE.None: pass
		FADE.In:
			if FadeIn(delta): time = 0; Fade = FADE.None; FadeFinished.emit();
		FADE.Out:
			if FadeOut(delta): time = 0; Fade = FADE.None; FadeFinished.emit()
		FADE.InOut:
			if FadeIn(delta, true): time = 0; FadeFinished.emit(); Fade = FADE.Out
		FADE.OutIn:
			if FadeOut(delta, true): time = 0; FadeFinished.emit(); Fade = FADE.In

	if GM._IntroPlayed and !musicStarted and !playing:
		#Fade = FADE.In
		print("asd")
		SetMusic()
		musicStarted = true

func _stop_BG_Music() -> void:
	stop()
	started = false
	
