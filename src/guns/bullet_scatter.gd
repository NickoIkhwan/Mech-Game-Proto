extends Area3D

const SPEED : float = 100.0
const RANGE : float = 40.0
const SCATTER : float = 0.3
var travel_dis : float = 0.0
var scatter_x = transform.basis.x * randf_range(-SCATTER, SCATTER)
var scatter_y = transform.basis.y * randf_range(-SCATTER, SCATTER)

func _physics_process(delta: float) -> void:
	
	
	position += -transform.basis.z * SPEED * delta
	position += scatter_x + scatter_y
	travel_dis += SPEED * delta
	
	if travel_dis > RANGE:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
		
