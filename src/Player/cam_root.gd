extends Node3D

func _ready() -> void:
	capture_mouse()
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("mouse_show"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_pressed("mouse_hide"):
		capture_mouse()
		
	if event is InputEventMouseMotion:
		%CamYaw.rotation_degrees.y -= event.relative.x * 0.2
		%CamPitch.rotation_degrees.x -= event.relative.y * 0.2
		
		%CamPitch.rotation_degrees.x = clamp(%CamPitch.rotation_degrees.x, -70.0, 50.0)

func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
