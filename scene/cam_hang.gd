extends Node3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%CamYawH.rotation_degrees.y = event.relative.x * 0.2
