@tool
extends Node3D

@export var axis: Vector3 = Vector3.UP
@export var period: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.rotate(axis.normalized(), TAU * delta / period)
