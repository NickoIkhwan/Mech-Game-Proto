extends PlayerState

func enter(previous_state_path : String, data := {}) -> void:
	print("slide")
	
func physics_update(_delta : float) -> void:
	player.velocity.x = lerp(player.velocity.x, player.target_acc.x, player.current * _delta)
	player.velocity.z = lerp(player.velocity.z, player.target_acc.z, player.current * _delta)

	player.move_and_slide()
	
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("dash") and Input.is_action_pressed("movement"):
		finished.emit(DASHING)
	elif not Input.is_action_pressed("movement"):
		finished.emit(IDLE)
