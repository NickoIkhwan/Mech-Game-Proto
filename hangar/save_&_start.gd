extends Button

func _pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Menu.tscn")
	MechConfigH.Torso = GlobalMechConfig.Torso
	MechConfigH.Leg = GlobalMechConfig.Leg
	MechConfigH.L_Arm = GlobalMechConfig.L_Arm
	MechConfigH.R_Arm = GlobalMechConfig.R_Arm
	MechConfigH.Head = GlobalMechConfig.Head
