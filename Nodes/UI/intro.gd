extends Control

#func _ready() -> void:
	#$AnimationPlayer.animation_finished.connect(_introOver)

func _introOver() -> void:
	print("over")
	GM._IntroPlayed = true
	$AnimationPlayer.stop()
	hide()

func _process(delta: float) -> void:
	if FK.JustPressed(AM.action("SkipIntro")):
		_introOver()

func play_intro() -> void:
	$AnimationPlayer.play("Intro")
