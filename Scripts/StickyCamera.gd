@tool
extends XRStickyPickable
class_name StickyCamera

@onready var area_3d: Area3D = $Area3D

@onready var sub_viewport: SubViewport = $SubViewport
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var photo_packed: PackedScene = preload("res://Scenes/Stickies/Photo.tscn")
@onready var marker_3d: Marker3D = $Marker3D

func _ready():
	contact_monitor = true
	max_contacts_reported = 32

func _on_released(_pickable: Variant, _by: Variant) -> void:
	print("released")
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
	for body in area_3d.get_overlapping_bodies():
		if body is XRStickyPickable and body != self:
			body.check_for_collision(self)

func take_picture():
	var photo: Node3D = photo_packed.instantiate()
	var tex: Image = sub_viewport.get_texture().get_image()
	for child in photo.get_children():
		if child is Sprite3D:
			(child as Sprite3D).texture = ImageTexture.create_from_image(tex)
	self.add_child(photo)
	photo.global_position = marker_3d.global_position
	photo.global_rotation = marker_3d.global_rotation
	photo.freeze = true
	print("taking picture")
	audio_stream_player_3d.play()
	tex.save_png("user://" + str(Time.get_unix_time_from_system()) + ".png")
