extends PlayerState

func enter(previous_state_path: String, data :={}):
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	
func phydics_update(_delta : float):
	player.velocity.y -= player.gravity * _delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("dash"):
		finished.emit(DASHING)
	elif Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		finished.emit(RUNNING)
	
