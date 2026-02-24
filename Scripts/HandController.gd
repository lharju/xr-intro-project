extends XRController3D

@onready var grab_area: Area3D = $GrabArea

# Are we currently grabbing 
var grab: GrabObject = null 

var transform_s: Transform3D

func _process(_delta: float) -> void:
	## Read inputs
	var grip_input: bool =  true if get_input("grip_click") else false
	##var trigger_input: bool = true if get_input("trigger_click") else false
	#
	#if grip_input and not grab:
	#	# begin grab
	#	for area: Area3D in grab_area.get_overlapping_areas():
	#		if area.get_parent() is GrabObject:
	#			grab = area.get_parent() as GrabObject
	#			transform_s = self.global_transform
	#			
	#elif not grip_input and grab:
	#	grab = null
	#elif grip_input and grab:
	#	var object_offset: Vector3 = grab.global_position - self.global_position
	#	grab.global_position -= object_offset
	#	
	#	
	#	var position_delta: Vector3 = self.global_transform.origin - transform_s.origin 
	#	var rotation_delta: Vector3 = self.global_transform.basis.get_euler() - transform_s.basis.get_euler()
	#	
	#	object_offset = object_offset.rotated(grab.basis.y, rotation_delta.y).rotated(grab.basis.x, rotation_delta.x).rotated(grab.basis.z, rotation_delta.z)
	#	
	#	grab.rotate_y(rotation_delta.y)
	#	grab.rotate_z(rotation_delta.z)
	#	grab.rotate_x(rotation_delta.x)
	#	
	#	grab.global_position += position_delta + object_offset
	#	
	#	transform_s = self.global_transform
	#return
	
	if grip_input and not grab:
		# begin grab
		for object in grab_area.get_overlapping_bodies():
			if object is GrabObject:
				grab = object as GrabObject
				grab.grab(self)
	elif not grip_input and grab:
		grab.release(self)
		grab = null
		
