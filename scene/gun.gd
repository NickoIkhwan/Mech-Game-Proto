extends Node3D

var shooting : bool = false

func _on_character_body_3d_shoot(is_shooting: bool) -> void:
	shooting = is_shooting
	
func _physics_process(delta: float) -> void:
	if shooting:
		shoot()

func shoot():
	const BULLET = preload("uid://cw7nucuyth0hp")
	var new_bullet = BULLET.instantiate()
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
