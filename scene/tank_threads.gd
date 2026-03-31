extends CharacterBody3D

var accel : float = 2

func _physics_process(delta: float) -> void:
	
	var input_dir = Input.get_vector("left","right","forward","back")
	var input_dir3D = Vector3( input_dir.x, 0.0, input_dir.y)
	var direction = %CamYaw.transform.basis * input_dir3D
	var target_acc = direction * Playervar.speed
	var current = accel
	
	velocity.x = lerp(velocity.x, target_acc.x, current * delta)
	velocity.z = lerp(velocity.z, target_acc.z, current * delta)
	
	move_and_slide()
	
	
