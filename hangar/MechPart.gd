extends Resource
class_name Mechpart

@export var part_name: String = "New Part"
@export var mesh_scene: PackedScene 
@export_enum("Head", "Torso", "L_Arm", "R_Arm", "Legs") var slot: String
@export var weight: float = 10.0
@export var armor_value: int = 5
