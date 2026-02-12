extends CharacterBody3D

@export var light: OmniLight3D = null
var light_rainbow: bool = false

@onready var left_hand: XRController3D = $XROrigin3D/LeftHand
@onready var right_hand: XRController3D = $XROrigin3D/RightHand
@onready var main_camera: XRCamera3D = $XROrigin3D/MainCamera

signal change_room

var a: bool = true
var b: bool = true

func _physics_process(_delta: float) -> void:
	
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	#var movement: Vector2 = right_hand.get_vector2("primary")
	#var _turn: Vector2 = left_hand.get_vector2("primary")
	#print(movement)
	
	
	if left_hand.get_input("ax_button") or left_hand.get_input("by_button"):
		print("Exiting")
		get_tree().quit()
	
	if right_hand.get_input("ax_button"):
		if not a:
			a = true
			light.is_rainbow = !light.is_rainbow
	else:
		a = false
	
	if right_hand.get_input("by_button"):
		if not b:
			b = true
			change_room.emit()
	else:
		b = false
	
	
	#var direction: Vector3 = (right_hand.basis.z * Vector3(-1, 0, -1)).normalized() * signf(movement.y)
	#var movement_plane: Vector3 = transform.basis * direction
	
	#right.play
	
	#velocity = movement_plane * 5
	#move_and_slide()
