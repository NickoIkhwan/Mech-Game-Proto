extends CharacterBody3D

const SPEED : float = 5.0
@onready var player = $"."

func _physics_process(delta: float) -> void:
	var player_pos = player.global_position
	
	velocity.y -= 5.0
	velocity.x = lerp(velocity.x, SPEED, 0.5)
	velocity.z = lerp(velocity.z, SPEED, 0.5)
	
	move_and_slide()
