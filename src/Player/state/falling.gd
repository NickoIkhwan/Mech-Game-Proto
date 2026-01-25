extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	print("fall")
	
	player.velocity.y -= 0.1
	set_physics_process(false)
	if "jumping" in previous_state_path:
		set_physics_process(true)
	
func physics_update(_delta : float) -> void:
	player.velocity.y = lerp(player.velocity.y, -50.0, 0.78 * _delta)	
	

	player.move_and_slide()
	player.is_consuming_boost = false
	player.consume_boost.emit(player.is_consuming_boost)
	
	if player.is_on_floor() and not Input.is_action_pressed("movement"):
		finished.emit(IDLE)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif  Input.is_action_pressed("dash") and Input.is_action_pressed("movement"):
		finished.emit(DASHING)
	elif player.is_on_floor() and Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		finished.emit(SLIDING)
