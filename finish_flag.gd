extends Node2D


@export var next_level: PackedScene


func _on_static_body_2d_interacted():
	get_tree().change_scene_to_packed(next_level)
