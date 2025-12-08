extends Area3D

const SPEED : float = 55.0
const RANGE : float = 40.0

var travel_dis : float = 0.0

func _physics_process(delta: float) -> void:
	position += -transform.basis.z * SPEED * delta
	travel_dis += SPEED * delta
	
	if travel_dis > RANGE:
		queue_free()
