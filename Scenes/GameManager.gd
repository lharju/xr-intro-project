extends Node3D


@export var room1: Node3D = null 
@export var room2: Node3D = null
@export var player: CharacterBody3D = null

var current_room: int = 1

func _on_vr_player_change_room() -> void:
	if current_room == 1:
		player.global_position = room2.global_position
		current_room = 2
	else:
		player.global_position = room1.global_position
		current_room = 1
