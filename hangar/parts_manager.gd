extends Node3D
class_name EquipManager

var equipped_parts = {}

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
	if root.name == target_name:
		return root
	for child in root.get_children():
		var found = _find_socket_recursive(child, target_name)
		if found:
			return found
	return null
	
func rebuild():
	var parts = {
		"Torso" : MechConfig.Torso,
		"L_arm" : MechConfig.L_Arm,
		"R_arm" : MechConfig.R_Arm,
		"Leg" : MechConfig.Leg,
		"Head" : MechConfig.Head
	}
	
	for slot in parts :
		var data = parts[slot]
		if data:
			var socket_path = slot + "_socket"
			var socket = _find_socket_recursive(self, socket_path)
			
			if socket:
				for child in socket.get_children():
					child.queue_free()
				
				var instance = data.model_scene.instantiate()
				socket.add_child(instance)
	
	
