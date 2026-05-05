extends DigSpot
@onready var hit_particle: CPUParticles2D = $HitParticle
@onready var sound_effect: AudioStreamPlayer2D = $SoundEffect

var area: Node2D
var digZone: Node2D

func Destroy() -> void:
	GiveValue()
	area.setCursorPos()
	hit_particle.finished.connect(hit_particle.queue_free)
	hit_particle.reparent(get_parent(), true)
	sound_effect.finished.connect(sound_effect.queue_free)
	sound_effect.reparent(get_parent())
	call_deferred("queue_free")

func GiveValue() -> void:
	digZone.addToInv(self)

var tween: Tween
func Spawn() -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)
	$Sprite2D.scale = Vector2(0, 0)
	tween.tween_property($Sprite2D, "scale", Vector2(1.5,1.5), 0.2)
	tween.tween_property($Sprite2D, "scale", Vector2(1.0,1.0), 0.5)

var hovered: bool = false
func _ready() -> void:
	$Sprite2D.frame = _SpriteFrame
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered() -> void:
	hovered = true
	area.setCursorPos(global_position)

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _shake() -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Sprite2D, "scale", Vector2(0.9, 0.9), 0.1)
	tween.chain().tween_property($Sprite2D, "scale", Vector2(1.0, 1.0), 0.1)
	pass

func _play_sound() -> void:
	if sound_effect.playing: sound_effect.stop()
	
	var audio = load(_Sounds[randi_range(0, _Sounds.size()-1)])
	sound_effect.stream = audio
	sound_effect.pitch_scale = randf_range(0.5, 1)
	
	sound_effect.play()

var canPress: bool = true
func _process(delta: float) -> void:
	if !GM.digReady: return
	if hovered:
		if FK.JustReleased(AM.action("L_Click")): canPress = true
		if canPress and PS._PStaminaCurr > 0 and FK.JustPressed(AM.action("L_Click")):
			canPress = false
			PS._PStaminaCurr -= 1
			GM.currUI.UpdateUI()
			_Health -= PS._PStrength
			hit_particle.emitting = true
			_play_sound()
			if _Health <= 0: Destroy()
			else: _shake()
		
	if hovered and Input.get_current_cursor_shape() != Input.CURSOR_POINTING_HAND:
		GM.digspotHover = true
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
