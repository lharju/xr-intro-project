extends XRController3D

var object_in_hand: Variant = null
@onready var snow_ball: PackedScene = preload("res://Scenes/Stickies/Snowball.tscn")

var trigger: bool = false
var grip: bool = false
func _process(_delta: float) -> void:
	var trigger_update: bool = true if get_input("trigger_click") else false
	if trigger_update and !trigger:
		if object_in_hand and object_in_hand is StickyCamera:
			(object_in_hand as StickyCamera).take_picture()
		
	trigger = trigger_update
	
	var grip_update = get_input("trigger") and get_input("trigger") > 0.80
	if grip_update and !grip:
		if global_position.y <= 0.1:
			var node_to_at: RigidBody3D = snow_ball.instantiate()
			node_to_at.ball_size = 0.05
			get_parent().get_parent().add_child(node_to_at)
			node_to_at.global_position = self.global_position
			
	grip = grip_update
		

func object_grapped(what):
	object_in_hand = what

func object_dropped():
	object_in_hand = null
