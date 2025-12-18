extends Node3D
@onready var player = preload("res://scene/Player.tscn")
@onready var player_instance : CharacterBody3D = null

func _ready() -> void:
	player_instance = player.instantiate()
	add_child(player_instance)
	
	if %Hang:
		player_instance.global_position = %Hang.global_position
	else:
		player_instance.global_position = Vector3(100,100,0)
