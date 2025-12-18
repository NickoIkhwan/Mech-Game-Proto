extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	pass
	
func physics_update(_delta : float) -> void:
	player.velocity.y -= 30.0 * _delta
	player.move_and_slide()
	player.is_consuming_boost = false
	player.consume_boost.emit(player.is_consuming_boost)
	
	if Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		finished.emit(RUNNING)
