extends PlayerState

func enter(previous_state_path: String, data :={}):
	pass

func physics_update(_delta : float):
	var input_dir = Input.get_vector("left","right","forward","back")
	var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	var direction = %CamYaw.transform.basis * input_dir3D
	var target_acc = direction * player.speed
	var current = player.accel
	
	player.velocity.x = lerp(player.velocity.x, target_acc.x, current * _delta)
	player.velocity.z = lerp(player.velocity.z, target_acc.z, current * _delta)
	player.velocity.y -= player.gravity * _delta
	
	if player.is_on_floor():
		finished.emit(IDLE)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("dash"):
		finished.emit(DASHING)
	elif Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		finished.emit(RUNNING)
