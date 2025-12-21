extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	print("run")
	
func physics_update(_delta : float) -> void:
	var input_dir = Input.get_vector("left","right","forward","back")
	var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	var direction = %CamYaw.transform.basis * input_dir3D
	var target_acc = direction * player.SPEED
	var current = player.accel
	
	if input_dir3D.length_squared() > 0:
		var target_basis = Basis.looking_at( direction, Vector3.UP)
		%Leg.global_transform.basis = %Leg.global_transform.basis.slerp(target_basis, 10.2 * _delta)
	
	player.velocity.x = lerp(player.velocity.x, target_acc.x, current * _delta)
	player.velocity.z = lerp(player.velocity.z, target_acc.z, current * _delta)
	
	player.move_and_slide()
	
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif  Input.is_action_pressed("dash") and Input.is_action_pressed("movement"):
		finished.emit(DASHING)
	elif not Input.is_action_pressed("movement"):
		%statetimer.start()
		if %statetimer.is_stopped():
			finished.emit(IDLE)
