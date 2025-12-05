extends Node3D

var dash_fov : float = 120
var normal_fov: float = 75
var dashing : bool = false


func _ready() -> void:
	capture_mouse()
	
func _on_character_body_3d_dash(is_dashing:bool) -> void:
		dashing = is_dashing
		
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("mouse_show"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_pressed("mouse_hide"):
		capture_mouse()
		
	if event is InputEventMouseMotion:
		%CamYaw.rotation_degrees.y -= event.relative.x * 0.2
		%CamPitch.rotation_degrees.x -= event.relative.y * 0.2
		
		%CamPitch.rotation_degrees.x = clamp(%CamPitch.rotation_degrees.x, -70.0, 50.0)

func _physics_process(delta: float) -> void:
	if dashing:
		%Camera3D.fov = lerp(%Camera3D.fov, dash_fov, 0.2 )
	else:
		%Camera3D.fov = lerp(%Camera3D.fov, normal_fov, 0.2 )



func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
