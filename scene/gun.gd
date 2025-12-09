extends Node3D


var shooting : bool = false
var ammo : float = 300.0
var ammo_per_sec : float = 30.0
var ammo_reload_rate : float = 50.0
var is_reloading : bool = false

func _on_character_body_3d_shoot(is_shooting: bool) -> void:
	shooting = is_shooting
	
func _physics_process(delta: float) -> void:
	
	if ammo == 300.0:
		is_reloading = false
	
	if ammo >= 0 and not is_reloading:
		if shooting and %Timer.is_stopped():
			shoot(delta)
			ammo -= ammo_per_sec * delta
			%Timer.start()
	else:
		reload(delta)
		is_reloading = true
		
	if ammo > 300:
		ammo = 300
		
	%ammo_progress.value = ammo
		

func shoot(delta):
	const BULLET = preload("uid://cw7nucuyth0hp")
	var new_bullet = BULLET.instantiate()
	var new_bullet2 = BULLET.instantiate()
	%Marker3D.add_child(new_bullet)
	%Marker3D2.add_child(new_bullet2)
	
	new_bullet.global_transform = %Marker3D.global_transform
	new_bullet2.global_transform = %Marker3D2.global_transform
	
func reload(delta):
	ammo += ammo_reload_rate * delta
