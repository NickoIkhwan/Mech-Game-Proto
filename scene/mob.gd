extends RigidBody3D

var speed = randf_range(20, 30)
@onready var player_node = $"."

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player_node.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	
