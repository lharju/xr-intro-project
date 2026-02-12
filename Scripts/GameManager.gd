extends Node3D


@export var rooms: Array[Node3D]
@export var player: CharacterBody3D = null

var current_room: int = 0

func _on_vr_player_change_room() -> void:
	current_room = (current_room + 1) % rooms.size()
	player.global_position = rooms[current_room].global_position
