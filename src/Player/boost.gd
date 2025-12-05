extends Node

signal boost_status(boost : float)
@onready var Player = $".."
var boost : float = 100.0
var is_boosting : bool = false
var dashing : bool = false

func _on_character_body_3d_consume_boost() -> void:
	is_boosting = true

func _on_character_body_3d_end_consume_boost() -> void:
	is_boosting = false
	
func _process(delta: float) -> void:
		
	if is_boosting:
		boost -= 50.0 * delta
	elif boost < 100.0 and Player.is_on_floor() and not dashing:
		boost += 800.0 * delta
	
	if boost_status:
		boost_status.emit(boost)
	
