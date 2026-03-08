extends Node3D
class_name EquipManagerMain

var equipped_parts = {}

func _ready() -> void:
	rebuild()

func equip_part(data: Mechpart):
	var socket_path = data.slot + "_socket"
	var socket = _find_socket_recursive(get_parent(), socket_path)
	
	if not socket:
		print ("couldnt find socket", socket_path)
		return
		
	for child in socket.get_children():
		child.queue_free()
		
	var new_part = data.mesh_scene.instantiate()
	socket.add_child(new_part)
	
	var child_socket = new_part.get_node_or_null("%child_socket")
	if child_socket:
		new_part.transform = child_socket.transform.affine_inverse()
		
	equipped_parts[data.slot] = data
	
func update_mech_stats():
	var total_weight = 0
	for part in equipped_parts.values():
		total_weight += part.weight
	
	print("total weight", total_weight)
	
func _find_socket_recursive(root: Node, target_name: String) -> Node:
	if root.is_queued_for_deletion():
		return null
	if root.name == target_name:
		return root
	for child in root.get_children():
		var found = _find_socket_recursive(child, target_name)
		if found:
			return found
	return null
	
func rebuild():
	if GlobalMechConfig.Torso != null:
		equip_part(GlobalMechConfig.Torso)
		rebuild2()
		
func rebuild2():
	if GlobalMechConfig.L_Arm != null:
		equip_part(GlobalMechConfig.L_Arm)
	if GlobalMechConfig.R_Arm != null:
		equip_part(GlobalMechConfig.R_Arm)
	if GlobalMechConfig.Leg != null:
		equip_part(GlobalMechConfig.Leg)
	if GlobalMechConfig.Head != null:
		equip_part(GlobalMechConfig.Head)
