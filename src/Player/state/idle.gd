extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	
func physics_update(_delta : float) -> void:
	player.velocity.y -= 30.0 * _delta
	player.move_and_slide()
	
	if not player.is_on_floor() and not Input.is_action_pressed("jump"):
		finished.emit(FALLING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		finished.emit(RUNNING)
