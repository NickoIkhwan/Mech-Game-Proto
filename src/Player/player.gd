class_name Player extends CharacterBody3D

signal consume_boost(is_consuming_boost:bool)
signal dash(is_dashing : bool)

@export var speed : float = 10.0
@export var fly_speed : float = 10.0
@export var gravity : float = 30.0
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
	

	if boost_player >= 0:
		if Input.is_action_pressed("jump"):
			velocity.y = lerp(velocity.y, fly_speed, 10.0 * delta)
			is_consuming_boost = true
			consume_boost.emit(is_consuming_boost)
		elif Input.is_action_pressed("dash"):
			if Input.is_action_pressed("movement"):
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
		
	#if target_acc.length_squared()==0:
		#if is_dashing:
	#		current = deaccel_dash
	#	elif not is_on_floor():
	#		current = deaccel_air
	#	else:
	#		current = deaccel
		
	
		
	move_and_slide()
