extends Node2D

@onready var shine_big: Sprite2D = $ShineBig
@onready var shine_small: Sprite2D = $ShineSmall
@onready var artifact: Sprite2D = $Artifact

var tween: Tween
func _ready() -> void:
	global_position = get_viewport_rect().size/2
	artifact.scale = Vector2(0,0)
	shine_big.scale = Vector2(0,0)
	shine_small.scale = Vector2(0,0)
	_show()
func _show() -> void:
	show()
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK)
	tween.tween_property(artifact, "scale", Vector2(1.5,1.5), 0.5)
	tween.parallel()
	tween.tween_property(shine_big, "scale",Vector2(1.5,1.5), 0.5)
	tween.parallel()
	tween.tween_property(shine_small, "scale", Vector2(1.5,1.5), 0.5)
	#await get_tree().create_timer(2.0).timeout
	tween.tween_property(artifact, "scale", Vector2(0,0), 0.5).set_delay(2.0)
	tween.parallel()
	tween.tween_property(shine_big, "scale", Vector2(0,0), 0.5).set_delay(2.0)
	tween.parallel()
	tween.tween_property(shine_small, "scale", Vector2(0,0), 0.5).set_delay(2.0).finished.connect(_hide)
	
func _hide():
	if tween: tween.kill()
	hide()

func _process(delta: float) -> void:
	if visible:
		shine_big.rotation_degrees += 0.5
		shine_small.rotation_degrees -= 1
