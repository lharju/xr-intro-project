extends GrabObject

@onready var look_at_target: Node3D = get_viewport().get_camera_3d()
@onready var camera_3d: Camera3D = $SubViewport/Camera3D

func _process(_delta: float) -> void:
	var fov_c: float = (self.global_position - look_at_target.global_position).length()
	camera_3d.look_at(self.global_position + (self.global_position - look_at_target.global_position), camera_3d.basis.y)
	camera_3d.fov = 5 + 25 * fov_c
	
