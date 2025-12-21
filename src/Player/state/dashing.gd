extends PlayerState

func physics_update(_delta : float) -> void:
	if player.boost_player >= 0 and not player.dash_locked:
		player.target_acc *= 2
		player.dashing_signal_true()
	else:
		player.dashing_signal_false()
	
	
	if not Input.is_action_pressed("dash") and Input.is_action_pressed("movement"):
		finished.emit(FALLING)
		player.dashing_signal_false()
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
		player.dashing_signal_false()
