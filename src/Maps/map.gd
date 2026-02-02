extends Node3D
@onready var player = preload("res://scene/Player.tscn")
@onready var player_instance : CharacterBody3D = null

@onready var enemy = preload("res://scene/Enemy.tscn")
@onready var enemy_instance : CharacterBody3D = null

func _ready() -> void:
	player_instance = player.instantiate()
	add_child(player_instance)
	
	if %Spawn:
		player_instance.global_position = %Spawn.global_position
	else:
		player_instance.global_position = Vector3(100,100,0)
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn_enemies"):
		enemy_instance = enemy.instantiate()
		add_child(enemy_instance)
		
		if %EnemySpawn:
			enemy_instance.global_position = %EnemySpawn.global_position
		else:
			enemy_instance.global_position = Vector3(100,100,0)
		
