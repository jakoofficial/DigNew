extends Node2D

@onready var tree_cam: Camera2D = $TreeCam

@export var zoomAmount: float = 0.25
@export var zoomMax: Vector2 = Vector2(1.25, 1.25)
@export var zoomMin: Vector2 = Vector2(0.5, 0.5)

func _ready() -> void:
	tree_cam.zoom = Vector2(1.0,1.0)

#var scrollIndex: int = 0
#func _unhandled_input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
			#scrollIndex = 0
		#elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			#scrollIndex = 1
		#if !event.is_pressed():
			#scrollIndex = -1

var lastPos: Vector2
func _input(event: InputEvent) -> void:
	if FK.Pressed(AM.action("R_Click")) and event is InputEventMouseMotion:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		tree_cam.global_position -= (event as InputEventMouseMotion).relative
	else:
		lastPos = Vector2.ZERO
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	if FK.JustPressed(AM.action("ZoomIn")):
		if tree_cam.zoom < zoomMax:
			tree_cam.zoom += Vector2(zoomAmount, zoomAmount)
		else: tree_cam.zoom = zoomMax
		print("In")
	elif FK.JustPressed(AM.action("ZoomOut")):
		if tree_cam.zoom > zoomMin:
			tree_cam.zoom -= Vector2(zoomAmount, zoomAmount)
		else: tree_cam.zoom = zoomMin
		print("Out")
