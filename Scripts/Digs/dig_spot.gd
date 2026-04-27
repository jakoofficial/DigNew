extends DigSpot

var area: Node2D

func Destroy() -> void:
	GiveOre()
	area.setCursorPos()
	call_deferred("queue_free")

func GiveOre() -> void:
	print("give ore")

var tween: Tween
func Spawn() -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)
	$Sprite2D.scale = Vector2(0, 0)
	tween.tween_property($Sprite2D, "scale", Vector2(1.5,1.5), 0.2)
	tween.tween_property($Sprite2D, "scale", Vector2(1.0,1.0), 0.5)

var hovered: bool = false
func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered() -> void:
	hovered = true
	area.setCursorPos(global_position)

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _process(delta: float) -> void:
	if !GM.digReady: return #Fix Timing
	if hovered:
		if FK.JustPressed(AM.action("L_Click")):
			Destroy()
	
	if hovered and Input.get_current_cursor_shape() != Input.CURSOR_POINTING_HAND:
		GM.digspotHover = true
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
