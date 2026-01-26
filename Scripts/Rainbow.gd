@tool
extends OmniLight3D

@export var is_rainbow: bool = false
var acc: float = 0.0


func _process(delta: float) -> void:
	if is_rainbow:
		acc = (acc + delta * 0.2) 
		self.light_color = Color.from_ok_hsl(acc, 0.8, 0.6, 1.0)
	else:
		self.light_color = Color.WHITE
	pass
