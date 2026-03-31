extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	print("dash")
	Playervar.turn_rate = 1
	player.velocity += player.direction * 5.0
	await get_tree().create_timer(0.2).timeout
	player.after_dashing = true
	
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
	
	if player.after_dashing and Input.is_action_pressed("movement"):
		finished.emit(SLIDING)
		player.dashing_signal_false()
	elif Input.is_action_just_released("dash") or Input.is_action_just_released("movement"):
		finished.emit(IDLE)
		player.dashing_signal_false()
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
		player.dashing_signal_false()
