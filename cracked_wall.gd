extends Node2D


func _on_static_body_2d_interacted():
	queue_free()
