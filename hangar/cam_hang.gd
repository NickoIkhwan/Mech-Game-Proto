extends Node3D

func _ready() -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
		
	if Input.is_action_just_released("zoom_in"):
		%SpringArm3D.spring_length -= 0.3
	elif Input.is_action_just_released("zoom_out"):
		%SpringArm3D.spring_length += 0.3
		
	%SpringArm3D.spring_length = clamp(%SpringArm3D.spring_length, 1, 5)
	
	if event is InputEventMouseMotion and Input.is_action_pressed("lmb"):
		%CamYawH.rotation_degrees.y -= event.relative.x * 0.4
		%CamPitchH.rotation_degrees.x -= event.relative.y * 0.4
		
		%CamPitchH.rotation_degrees.x = clamp(%CamPitchH.rotation_degrees.x, -70, 70)
		
func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func show_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
