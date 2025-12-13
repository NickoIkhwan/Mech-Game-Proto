extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var player: CharacterBody3D
var health : float = 100
var player_close : bool = false

func _ready() -> void:
	%Timer1.start()
	await ready 
	await get_tree().process_frame 
	var parent_node = get_parent()
	
	if parent_node != null:
		player = parent_node.get_node("Player")
		
		if not is_instance_valid(player):
			print("ERROR: Player node not found at path: get_parent().get_node('Player')")
	else:
		print("CRITICAL ERROR: Enemy node has no parent!")
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ai_testing"):
		var random_pos = Vector3.ZERO
		random_pos.x = randf_range(-40.0,40.0)
		random_pos.z = randf_range(-40.0,40.0)
	
func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	var target_dir = direction * 5.0 
	velocity.y -= 4.0
	
	velocity.x = lerp(velocity.x, target_dir.x , 5.0 * delta)
	velocity.z = lerp(velocity.z, target_dir.z , 5.0 * delta)
	
	if player_close:
		follow_player()
		
	if player:
		%Head.look_at(player.global_position)
		
		
	move_and_slide()

func take_damage():
	print("hit")
	health -= 2
	velocity.y = 40.0
	if health <= 0 :
		set_physics_process(false)
		queue_free()
		

func _on_timer_1_timeout() -> void:
	if player and not player_close:
		follow_player()
		%Timer1.start()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_close = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_close = false

func follow_player():
	var target = player.global_position
	navigation_agent_3d.set_target_position(target)
