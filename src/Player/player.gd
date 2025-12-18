class_name Player extends CharacterBody3D

signal shoot(is_shooting : bool)
signal consume_boost(is_consuming_boost : bool)
signal dash(is_dashing : bool)
signal aim(is_aiming : bool)

const SPEED : float = 10.0
const FLY_SPEED : float = 25.0
const DASH_MULTIPLIER : float = 4
@onready var boost_Gauge : ProgressBar = %ProgressBar
@onready var gun = preload("res://scene/gun.tscn")
var accel : float = 5.0
var deaccel : float = 3.0
var deaccel_air : float = 0.3
var deaccel_dash : float = 0.1
var boost_player : float 
var is_shooting : bool = false
var is_dashing : bool = false
var is_consuming_boost : bool = false
var dash_locked : bool = false
var is_aiming : bool = false

func _ready() -> void:
	var gun_inst = gun.instantiate()
	%Arm_port.add_child(gun_inst)

	
func _on_boost_boost_status(boost: float) -> void:
	boost_player = boost
	
#func _physics_process(delta: float) -> void:
	#var input_dir = Input.get_vector("left","right","forward","back")
	#var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	#var direction = %CamYaw.transform.basis * input_dir3D
	#var target_acc = direction * SPEED
	#var current = accel
	#
	#if input_dir3D.length_squared() > 0:
		#var target_basis = Basis.looking_at( direction, Vector3.UP)
		#%Leg.global_transform.basis = %Leg.global_transform.basis.slerp(target_basis, 10.2 * delta)
	#
#
	#if not is_dashing:
		#velocity.y -= 30.0 * delta
	#
	#if boost_player >= 0:
		#if Input.is_action_pressed("jump"):
			#velocity.y = lerp(velocity.y, FLY_SPEED, 10.0 * delta)
			#is_consuming_boost = true
			#consume_boost.emit(is_consuming_boost)
		#elif Input.is_action_pressed("dash") and not dash_locked:
			#if Input.is_action_pressed("movement"):
				#target_acc *= DASH_MULTIPLIER
				#dashing_signal_true()
		#else:
			#dashing_signal_false()
	#else:
		#dashing_signal_false()
		#dash_locked = true
	#
	#if Input.is_action_pressed("Shoot"):
		#is_shooting = true
		#shoot.emit(is_shooting)
	#else:
		#is_shooting = false
		#shoot.emit(is_shooting)
		#
	#if Input.is_action_pressed("aim"):
		#is_aiming = true
		#aim.emit(is_aiming)
	#else:
		#is_aiming = false
		#aim.emit(is_aiming)
		#
	#if not Input.is_action_pressed("dash"):
		#dash_locked = false
		#
	#if target_acc.length_squared()==0:
		#if is_dashing:
			#current = deaccel_dash
		#elif not is_on_floor():
			#current = deaccel_air
		#else:
			#current = deaccel
		#
	#velocity.x = lerp(velocity.x, target_acc.x, current * delta)
	#velocity.z = lerp(velocity.z, target_acc.z, current * delta)
	#
	#move_and_slide()
	
	
func dashing_signal_true():
	is_consuming_boost = true
	is_dashing = true
	consume_boost.emit(is_consuming_boost)
	dash.emit(is_dashing)
	
func dashing_signal_false():
	is_consuming_boost = false
	is_dashing = false
	consume_boost.emit(is_consuming_boost)
	dash.emit(is_dashing)
	

	
