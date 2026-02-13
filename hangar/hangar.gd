extends Node3D


func _ready() -> void:
	var player = preload("res://hangar/PlayerH.tscn")
	var player_instance = player.instantiate()
	add_child(player_instance)
	
	if %Hang:
		player_instance.global_transform = %Hang.global_transform
	else:
		player_instance.global_position = Vector3(100,100,0)
