extends Node3D
@onready var player = preload("res://scene/Player.tscn")
@onready var player_instance : CharacterBody3D = null


func _ready() -> void:
	player_instance = player.instantiate()
	add_child(player_instance)
	
	if %Spawn:
		player_instance.global_position = %Spawn.global_position
	else:
		player_instance.global_position = Vector3(100,100,0)
		
func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "update_target" , player_instance.global_transform.origin)
