class_name Player extends CharacterBody3D


signal shoot(is_shooting : bool)
signal consume_boost(is_consuming_boost : bool)
signal dash(is_dashing : bool)
signal aim(is_aiming : bool)


@onready var boost_Gauge : ProgressBar = %ProgressBar
@onready var gun = preload("res://scene/gun.tscn")
#@onready var tip: Vector3 = %CamCast2.global_position + %CamCast2.target_position
var input_dir : Vector2
var input_dir3D : Vector3
var direction : Vector3
var target_acc : Vector3
var current : float
var accel : float = 5.0
var deaccel : float = 3.0
var deaccel_air : float = 0.3
var deaccel_dash : float = 0.1
var boost_player : float 


var is_shooting : bool = false
var is_dashing : bool = false
var is_consuming_boost : bool = false
var dash_locked : bool = false
var after_dashing : bool = false
var is_aiming : bool = false
var controls_enabled : bool = true

func _ready() -> void:
	var gun_inst = gun.instantiate()
	%Arm_port.add_child(gun_inst)
	
	if after_dashing:
		print("after_dash")

	
func _on_boost_boost_status(boost: float) -> void:
	boost_player = boost

func calculate_movement_variables(_delta: float) -> void:
	if not controls_enabled:
		input_dir = Vector2.ZERO
		input_dir3D = Vector3.ZERO
		direction = Vector3.ZERO
		target_acc = Vector3.ZERO
		return
	
	input_dir = Input.get_vector("left","right","forward","back")
	input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	direction = %CamYaw.transform.basis * input_dir3D
	target_acc = direction * Playervar.speed
	current = accel
	
	if input_dir3D.length_squared() > 0:
		var target_basis = Basis.looking_at( direction, Vector3.UP)
		%Leg.global_transform.basis = %Leg.global_transform.basis.slerp(target_basis, 10.2 * _delta)
	
func _physics_process(delta: float) -> void:
	calculate_movement_variables(delta)
	
	if %CamCast.is_colliding():
		var count = %CamCast.get_collision_count()
		print("Detected ", count, " objects")
		
		for i in range(count):
			var body = %CamCast.get_collider(i)
			var point = %CamCast.get_collision_point(i)
			print("Hit #", i, ": ", body.name, " at ", point)
	
	if boost_player == 100 and not Input.is_action_pressed("dash"):
		dash_locked = false
	elif boost_player <= 0.1 :
		dash_locked = true

	
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
	

	
