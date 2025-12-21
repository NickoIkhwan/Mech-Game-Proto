extends PlayerState



func enter(previous_state_path : String, data := {}) -> void:
	pass
func physics_update(_delta : float) -> void:
	
	player.velocity.y -= 30.0 * _delta
	
	if player.boost_player >= 0:
		player.velocity.y = lerp(player.velocity.y, player.FLY_SPEED, 30.0 * _delta)
		player.is_consuming_boost = true
		player.consume_boost.emit(player.is_consuming_boost)
	else:
		player.is_consuming_boost = false
		player.consume_boost.emit(player.is_consuming_boost)
		
	player.move_and_slide()
	
	
	if not player.is_on_floor() and not Input.is_action_pressed("jump"):
		finished.emit(FALLING)
	elif  Input.is_action_pressed("dash") and Input.is_action_pressed("movement"):
		finished.emit(DASHING)
	elif Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		finished.emit(RUNNING)
