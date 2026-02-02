extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	print("dash")
	player.after_dashing = true
	player.velocity += player.direction * 5.0
	
func physics_update(_delta : float) -> void:
	if player.boost_player >= 0.1 and not player.dash_locked:
		player.target_acc *= Playervar.dash_multiplier
		player.dashing_signal_true()
	else:
		player.dashing_signal_false()
		player.velocity.y -= 0.2
		player.dash_locked = true
		
	player.velocity.x = lerp(player.velocity.x, player.target_acc.x, player.current * _delta)
	player.velocity.z = lerp(player.velocity.z, player.target_acc.z, player.current * _delta)

	player.move_and_slide()
	
	if player.dash_locked or Input.is_action_just_released("dash") and Input.is_action_pressed("movement"):
		finished.emit(SLIDING)
		player.dashing_signal_false()
	elif Input.is_action_just_released("dash") or Input.is_action_just_released("movement"):
		finished.emit(IDLE)
		player.dashing_signal_false()
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
		player.dashing_signal_false()
