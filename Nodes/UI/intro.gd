extends Control

func _introOver() -> void:
	GM._IntroPlayed = true
	$AnimationPlayer.stop()
	hide()

func _process(delta: float) -> void:
	if FK.JustPressed(AM.action("SkipIntro")):
		_introOver()

func play_intro() -> void:
	$AnimationPlayer.play("Intro")
