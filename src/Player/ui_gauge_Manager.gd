extends Node

@onready var boost_Gauge : ProgressBar = %ProgressBar
var boost_value : float

func _on_boost_boost_status(boost: float) -> void:
	boost_value = boost
	
func _physics_process(delta: float) -> void:
	if boost_Gauge:
		boost_Gauge.value = boost_value
