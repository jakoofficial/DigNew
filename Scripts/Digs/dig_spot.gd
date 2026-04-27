extends DigSpot

var area: Node2D

func Destroy() -> void:
	pass
	
func GiveOre() -> void:
	pass

var hovered: bool = false
func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered() -> void:
	hovered = true
	area.setCursorPos(global_position)
	#Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited() -> void:
	hovered = false
	GM.digspotHover = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

#func _input(event: InputEvent) -> void:
	#var mouse_pos = get_global_mouse_position()
	#
	#if mouse_pos.x > (global_position.x-32) and mouse_pos.x < global_position.x+32:
		#if mouse_pos.y > (global_position.y-32) and mouse_pos.y < global_position.y+32:
			#hovered = true
		#else:
			#hovered = false
	#else:
		#hovered = false


func _process(delta: float) -> void:
	#if area != null: area.emit_signal("setCursor", self.global_position)
	if hovered and Input.get_current_cursor_shape() != Input.CURSOR_POINTING_HAND:
		GM.digspotHover = true
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
