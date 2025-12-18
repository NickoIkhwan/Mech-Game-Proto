extends Node3D


var shooting : bool = false
var ammo : float = 30.0
var ammo_per_sec : float = 5.0
var ammo_reload_rate : float = 50.0
var is_reloading : bool = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Shoot"):
		shooting = true
	else:
		shooting = false
		
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * 0.2
		rotation_degrees.x = clamp(rotation_degrees.x, -70.0, 50.0)
	
func _physics_process(delta: float) -> void:
	
	
	if ammo == 30.0:
		is_reloading = false
	
	if ammo >= 0 and not is_reloading:
		if shooting and %Timer.is_stopped():
			shoot(delta)
			ammo -= ammo_per_sec * delta
			%Timer.start()
	else:
		reload(delta)
		is_reloading = true
		
	if ammo > 30.0:
		ammo = 30.0
		
	%ammo_progress.value = ammo
		

func shoot(delta):
	const BULLET = preload("res://scene/bullet_scatter.tscn")
	var bullet_count = 8
	for i in range(bullet_count):
		var new_bullet = BULLET.instantiate() 
		%Marker3D.add_child(new_bullet)
	
		new_bullet.global_transform = %Marker3D.global_transform
	
func reload(delta):
	ammo += ammo_reload_rate * delta
