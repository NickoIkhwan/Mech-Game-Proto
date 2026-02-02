extends Node3D

var dash_length : float = 15.0
var normal_length: float = 3.0
var aim_length : float = 4.0
var dash_fov : float = 120.0
var normal_fov: float = 75.0
var aim_fov : float = 4.0
var dashing : bool = false
var aiming : bool = false
var length_tween : Tween

func _ready() -> void:
	capture_mouse()
	
func _on_character_body_3d_aim(is_aiming: bool) -> void:
	aiming = is_aiming
	
func _on_character_body_3d_dash(is_dashing:bool) -> void:
		dashing = is_dashing

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("mouse_show"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_pressed("mouse_hide"):
		capture_mouse()
		
	if event is InputEventMouseMotion:
		# Check if controls are enabled on the parent player
		var player = get_parent()
		if player and player.has_method("is_controls_enabled") or player.get("controls_enabled") == false:
			return
		
		%CamYaw.rotation_degrees.y -= event.relative.x * 0.2
		%CamPitch.rotation_degrees.x -= event.relative.y * 0.2
		
		%CamPitch.rotation_degrees.x = clamp(%CamPitch.rotation_degrees.x, -70.0, 50.0)

func update_spring_length( target_value : float):
	if length_tween:
		length_tween.kill()
		
	length_tween = create_tween()
	length_tween.tween_property(%SpringArm3D, "spring_length", target_value, 0.1)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)
		
func _physics_process(delta: float) -> void:
	if dashing and not aiming:
		%SpringArm3D.spring_length = lerp(%SpringArm3D.spring_length, dash_length, 0.7)
		%Camera3D.fov = lerp(%Camera3D.fov, dash_fov, 0.1)
	else:
		%SpringArm3D.spring_length = lerp(%SpringArm3D.spring_length, normal_length, 0.1)
		%Camera3D.fov = lerp(%Camera3D.fov, normal_fov, 0.1)
		
	if aiming:
		%SpringArm3D.spring_length = lerp(%SpringArm3D.spring_length, aim_length, 0.5 )
	else:
		%SpringArm3D.spring_length = lerp(%SpringArm3D.spring_length, normal_length, 0.5 )
		

func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
