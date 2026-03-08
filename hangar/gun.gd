extends Button

@export var part_to_equip: Mechpart

func _pressed() -> void:
	MechConfigH.R_Weapon = part_to_equip
	var manager = get_tree().get_first_node_in_group("partsmanager")
	print("pressed")
	if part_to_equip:
		manager.equip_part(part_to_equip)
	print(MechConfigH.R_Weapon.resource_path)
