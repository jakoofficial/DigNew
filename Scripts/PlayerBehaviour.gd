extends CharacterBody2D

@export_enum("left", "right", "down", "none") var dir = 3
@onready var ray: RayCast2D = $RayCast2D

var grav: float = 980.0
var speed: float = 200.0
var direction

func _ready() -> void:
	get_parent().startPlayerPos = global_position

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		ray.enabled = true
		if event.is_pressed() and event.keycode == KEY_SPACE:
			if ray.is_colliding():
				var spot = ray.get_collider()
				if spot != null:
					spot.emit_signal("dug")
		if event.is_pressed() and (event.keycode == KEY_A or event.keycode == KEY_LEFT):
			dir = "left"
		if event.is_pressed() and (event.keycode == KEY_D or event.keycode == KEY_RIGHT):
			dir = "right"
		if event.is_pressed() and (event.keycode == KEY_S or event.keycode == KEY_DOWN):
			dir = "down"
		_setRayDir()

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
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
