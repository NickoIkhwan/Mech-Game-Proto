extends Node

signal boost_status(boost : float)
@onready var Player = $"../.."
var boost : float = 100.0
var consume_rate : float = 100.0
var recharge_rate: float = 120.0
var is_boosting : bool = false
var dashing : bool = false

func _on_character_body_3d_dash(is_dashing: bool) -> void:
	dashing = is_dashing

func _on_character_body_3d_consume_boost(is_consuming_boost: bool) -> void:
	is_boosting = is_consuming_boost
	
func _process(delta: float) -> void:
		
	if is_boosting:
		boost -= consume_rate * delta
	elif boost < 100.0  and Player.is_on_floor():
		boost += recharge_rate * delta

	if boost > 100:
		boost = 100
		
	if boost_status:
		boost_status.emit(boost)

	
