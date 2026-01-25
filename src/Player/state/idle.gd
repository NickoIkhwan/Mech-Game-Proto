extends PlayerState
var deaccel : float 

func enter(previous_state_path : String, data := {}) -> void:
	print("idle")
	
	if player.is_on_floor():
		deaccel = player.deaccel
	elif "dashing" in previous_state_path:
		deaccel = player.deaccel_dash
	else:
		deaccel = player.deaccel_air
	
func physics_update(_delta : float) -> void:

	player.velocity.x = lerp(player.velocity.x, player.target_acc.x, deaccel * _delta)
	player.velocity.z = lerp(player.velocity.z, player.target_acc.z, deaccel * _delta)
	player.velocity.y -= 30.0 * _delta
	player.move_and_slide()
	
	if not player.is_on_floor() and not Input.is_action_pressed("jump"):
		finished.emit(FALLING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		finished.emit(RUNNING)
