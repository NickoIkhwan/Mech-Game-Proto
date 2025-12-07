extends PlayerState

func enter(previous_state_path: String, data :={}):
	pass
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		player.velocity.y += lerp(player.velocity.y, player.fly_speed, 10.0 * delta)
	else:
		finished.emit(FALLING)
		
	if Input.is_action_pressed("dash"):
		finished.emit(DASHING)
	elif player.is_on_floor() and player.velocity.x == 0 and player.velocity.z == 0 :
		finished.emit(IDLE)
	
