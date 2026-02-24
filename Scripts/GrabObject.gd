extends RigidBody3D
class_name GrabObject

var grabbed: bool = false
var original_parent: Node3D = null
var grab_parent: Node3D = null
var grab_mod_parent: Node3D = null


var transform_start: Transform3D = Transform3D.IDENTITY

func _ready() -> void:
	original_parent = get_parent()

func grab(node: Node3D) -> void:
	if not grab_parent:
		grab_parent = node
		self.reparent(node, true)
		self.freeze = true
	else:
		grab_mod_parent = node
		transform_start = node.global_transform


func release(node: Node3D) -> void:
	if grab_mod_parent == node:
		grab_mod_parent = null
	elif grab_mod_parent:
		# Change grab origin
		grab_parent = grab_mod_parent
		grab_mod_parent = null
		self.reparent(grab_parent, true)
	else:
		grab_parent = null
		self.freeze = false
		self.reparent(original_parent, true)

func _physics_process(_delta: float) -> void:
	if grab_mod_parent:
		var position_delta: Vector3 = transform_start.origin - grab_mod_parent.global_transform.origin
		var rotation_delta: Vector3 = transform_start.basis.get_euler() - grab_mod_parent.global_transform.basis.get_euler()
		self.global_position -= position_delta
		
		self.rotate_y(-rotation_delta.y)
		self.rotate_x(-rotation_delta.x)
		self.rotate_z(-rotation_delta.z)
		transform_start = grab_mod_parent.global_transform

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	var has_area: bool = false
	for child in self.get_children():
		if child is Area3D:
			has_area = true
			break
	
	if not has_area:
		warnings.append("GrabObject has no Area3D")
		
	return warnings
