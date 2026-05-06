extends Node2D

@onready var tree_cam: Camera2D = $TreeCam

@export var zoomAmount: float = 0.25
@export var zoomMax: Vector2 = Vector2(1.25, 1.25)
@export var zoomMin: Vector2 = Vector2(0.5, 0.5)

func _ready() -> void:
	tree_cam.zoom = Vector2(0.75,0.75)
	FM.SaveGame()


var lastPos: Vector2
func _input(event: InputEvent) -> void:
	if FK.Pressed(AM.action("R_Click")) and event is InputEventMouseMotion:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		tree_cam.global_position -= (event as InputEventMouseMotion).relative
		print("oressed")
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
