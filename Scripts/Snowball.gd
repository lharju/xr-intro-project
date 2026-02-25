@tool
extends XRStickyPickable

@export var ball_size: float  = 0.2:
	set(a):
		ball_size = a
		self.mass = ball_size * 10
		for child in self.get_children():
			child.scale = Vector3(ball_size, ball_size, ball_size)

@onready var area_3d: Area3D = $Area3D
@onready var pos: Vector3 = self.position

var thrown: bool = false

func _ready():
	contact_monitor = true
	max_contacts_reported = 32

func _physics_process(_delta: float) -> void:
	var movement: float = (self.position - pos).length()
	pos = self.position
	if is_picked_up() == false and self.global_position.y < ball_size * 1.1:
		ball_size += movement * 0.05
	
	# Write code for if object is thrown

func _on_released(_pickable: Variant, _by: Variant) -> void:
	print("released")
	thrown = true
	check_for_collision()

func check_for_collision(a = null):
	for body in area_3d.get_overlapping_bodies():
		if body is XRStickyPickable and body != a and body != self:
			set_deferred("freeze", true)
			body.set_deferred("freeze", true)
			return
	set_deferred("freeze", false)


func _on_picked_up(_pickable: Variant) -> void:
	print("picked up")
	thrown = false
	for body in area_3d.get_overlapping_bodies():
		if body is XRStickyPickable and body != self:
			body.check_for_collision(self)
