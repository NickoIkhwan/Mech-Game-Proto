extends Node3D



func _ready() -> void:
	var player = preload("res://scene/Player.tscn")
	var player_instance = player.instantiate()
	add_child(player_instance)
	
	if %Spawn:
		player_instance.global_position = %Spawn.global_position
	else:
		player_instance.global_position = Vector3(100,100,0)
