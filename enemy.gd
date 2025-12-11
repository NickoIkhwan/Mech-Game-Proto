extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ai_testing"):
		var random_pos = Vector3.ZERO
		random_pos.x = randf_range(-40.0,40.0)
		random_pos.z = randf_range(-40.0,40.0)
		navigation_agent_3d.set_target_position(random_pos)
		
func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	var target_dir = direction * 5.0 
	velocity.y -= 4.0
	
	velocity.x = lerp(velocity.x, target_dir.x , 5.0 * delta)
	velocity.z = lerp(velocity.z, target_dir.z , 5.0 * delta)
	move_and_slide()
