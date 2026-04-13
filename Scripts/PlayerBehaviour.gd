extends CharacterBody2D

@export_enum("left", "right", "down", "none") var dir = 3
@onready var ray: RayCast2D = $RayCast2D

var grav: float = 980.0
var speed: float = 200.0
var direction

func _ready() -> void:
	get_parent().startPlayerPos = global_position

func custom_input() -> void:
		ray.enabled = true
		if ray.is_colliding() and ray.get_collider() != null and ray.get_collider().canDestroy:
			GM.curScene.cursor.show()
			GM.curScene.cursor.global_position = ray.get_collider().global_position
			if GM.curUI.digsleft > 0 and FK.JustPressed(AM.action("Dig")):
				var spot = ray.get_collider()
				if spot != null:
					spot.emit_signal("dug")

		else: GM.curScene.cursor.hide()
		
		if FK.Pressed(AM.action("Left")):
			dir = "left"
		if FK.Pressed(AM.action("Right")):
			dir = "right"
		if FK.Pressed(AM.action("Down")):
			dir = "down"
		_setRayDir()

func _physics_process(delta: float) -> void:
	custom_input()
	
	direction = FK.Axis(AM.action("Right"), AM.action("Left"))
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0
	
	if !is_on_floor():
		velocity.y = grav * delta * 20
	
	move_and_slide()

func _setRayDir() -> void:
	match dir:
		"left":
			ray.target_position = Vector2(-50.0, 0.0)
		"right":
			ray.target_position = Vector2(50.0, 0.0)
		"down":
			ray.target_position = Vector2(0.0, 50.0)
