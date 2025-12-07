extends PlayerState

func enter(previous_state_path: String, data :={}):
	pass
	
func physics_update(_delta : float):
	var input_dir = Input.get_vector("left","right","forward","back")
	var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	var direction = %CamYaw.transform.basis * input_dir3D
	var target_acc = direction * player.speed
	var current = player.accel
	
	if input_dir3D.length_squared() > 0:
		var target_basis = player.basis.looking_at( -direction, Vector3.UP)
		%Leg.global_transform.basis = %Leg.global_transform.basis.slerp(target_basis, 10.2 * _delta)
	
	player.velocity.x = lerp(player.velocity.x, target_acc.x, current * _delta)
	player.velocity.z = lerp(player.velocity.z, target_acc.z, current * _delta)
	
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("dash"):
		finished.emit(DASHING)
	elif player.is_on_floor() and player.velocity.x == 0 and player.velocity.z == 0 :
		finished.emit(IDLE)
	
