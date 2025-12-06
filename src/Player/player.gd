extends CharacterBody3D

signal consume_boost(is_consuming_boost:bool)
signal dash(is_dashing : bool)

const SPEED : float = 10.0
const FLY_SPEED : float = 25.0
@onready var boost_Gauge : ProgressBar = %ProgressBar
var accel : float = 5.0
var deaccel : float = 6.0
var deaccel_air : float = 1.0
var deaccel_dash : float = 0.1
var boost_player : float 
var is_dashing : bool = false
var is_consuming_boost : bool = false


func _on_boost_boost_status(boost: float) -> void:
	boost_player = boost
	
func _physics_process(delta: float) -> void:
	
	var input_dir = Input.get_vector("left","right","forward","back")
	var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	var direction = %CamYaw.transform.basis * input_dir3D
	var target_acc = direction * SPEED
	var current = accel
	
	if input_dir3D.length_squared() > 0:
		var target_basis = basis.looking_at( -direction, Vector3.UP)
		%Leg.global_transform.basis = %Leg.global_transform.basis.slerp(target_basis, 10.2 * delta)
	
	if not is_dashing:
		velocity.y -= 30.0 * delta
	
	if boost_player >= 0:
		if Input.is_action_pressed("jump"):
			velocity.y = lerp(velocity.y, FLY_SPEED, 10.0 * delta)
			is_consuming_boost = true
			consume_boost.emit(is_consuming_boost)
		elif Input.is_action_pressed("dash"):
			if Input.is_action_pressed("movement"):
				target_acc *= 3
				velocity.y = 0.0
				is_consuming_boost = true
				is_dashing = true
				consume_boost.emit(is_consuming_boost)
				dash.emit(is_dashing)
		else:
			is_consuming_boost = false
			is_dashing = false
			consume_boost.emit(is_consuming_boost)
			dash.emit(is_dashing)
	else:
		is_consuming_boost = false
		is_dashing = false
		consume_boost.emit(is_consuming_boost)
		dash.emit(is_dashing)
		
	if target_acc.length_squared()==0:
		if is_dashing:
			current = deaccel_dash
		elif not is_on_floor():
			current = deaccel_air
		else:
			current = deaccel
		
	velocity.x = lerp(velocity.x, target_acc.x, current * delta)
	velocity.z = lerp(velocity.z, target_acc.z, current * delta)
	
		
	move_and_slide()
