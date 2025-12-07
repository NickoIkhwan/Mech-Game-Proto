class_name State extends Node

signal finished(next_state_path : String, data : Dictionary )

func handle_input(_eveent:InputEvent):
	pass

func update(_delta : float):
	pass
	
func phydics_update(_delta : float):
	pass
	
func enter(previous_state_path: String, data :={}): 
	pass

func exit():
	pass
