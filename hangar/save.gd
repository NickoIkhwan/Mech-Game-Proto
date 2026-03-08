extends Button

func _pressed() -> void:
	GlobalMechConfig.Torso = MechConfigH.Torso
	GlobalMechConfig.Leg = MechConfigH.Leg
	GlobalMechConfig.L_Arm = MechConfigH.L_Arm
	GlobalMechConfig.R_Arm = MechConfigH.R_Arm
	GlobalMechConfig.Head = MechConfigH.Head
