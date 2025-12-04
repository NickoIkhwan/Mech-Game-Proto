extends CharacterBody3D

signal consume_boost
signal end_consume_boost
signal dash(is_dashing : bool)

const SPEED = 5.0
@onready var boost_Gauge : ProgressBar = %ProgressBar
var accel : float = 5.0
var deaccel : float = 6.0
var deaccel_air : float = 1.0
var deaccel_dash : float = 0.1
var boost_player : float 
var is_dashing : bool = false

func _on_boost_boost_status(boost: float) -> void:
	boost_player = boost
	
func _physics_process(delta: float) -> void:
	
	var input_dir = Input.get_vector("left","right","forward","back")
	var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	var direction = %CamYaw.transform.basis * input_dir3D
	var consuming_boost = Input.is_action_pressed("dash") or Input.is_action_pressed("jump")
	var target_acc = direction * SPEED
	
	if input_dir3D.length_squared() > 0:
		var target_basis = basis.looking_at( -direction, Vector3.UP)
		%Mesh.global_transform.basis = %Mesh.global_transform.basis.slerp(target_basis, 10.2 * delta)

	velocity.y -= 20.0 * delta
	
	if boost_player >= 0:
		if Input.is_action_pressed("jump"):
			velocity.y = 10.0 
			consume_boost.emit()
		elif Input.is_action_pressed("dash"):
			target_acc *= 2
			is_dashing = true
			consume_boost.emit()
			dash.emit(is_dashing)
		else:
			end_consume_boost.emit()
			is_dashing = false
	else:
		end_consume_boost.emit()
		is_dashing = false
		
	
	var current = accel
	if target_acc.length_squared()==0:
		if Input.is_action_pressed("dash"):
			current = deaccel_dash
		elif not is_on_floor():
			current = deaccel_air
		else:
			current = deaccel
		
	velocity.x = lerp(velocity.x, target_acc.x, current * delta)
	velocity.z = lerp(velocity.z, target_acc.z, current * delta)
	
		
	move_and_slide()
