extends PlayerState



func enter(previous_state_path : String, data := {}) -> void:
	print("jump")
	
	if previous_state_path == "RUNNING" and player.is_on_floor():
		player.velocity.y = 40.0
		
		
func physics_update(_delta : float) -> void:
	
	player.velocity.y -= 20.0 * _delta
	
	if player.boost_player >= 0.1:
		player.velocity.y = lerp(player.velocity.y, Playervar.fly_speed, 10.0 * _delta)
		player.target_acc *= 3.0
		player.is_consuming_boost = true
		player.consume_boost.emit(player.is_consuming_boost)
	else:
		player.is_consuming_boost = false
		player.consume_boost.emit(player.is_consuming_boost)
		
	player.velocity.x = lerp(player.velocity.x, player.target_acc.x, player.current * _delta)
	player.velocity.z = lerp(player.velocity.z, player.target_acc.z, player.current * _delta)

	player.move_and_slide()
	
	
	if not player.is_on_floor() and not Input.is_action_pressed("jump"):
		finished.emit(FALLING)
	elif  Input.is_action_pressed("dash") and Input.is_action_pressed("movement"):
		finished.emit(DASHING)
	
