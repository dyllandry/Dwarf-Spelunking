extends Node2D


func _on_static_body_2d_interacted():
	PlayerInventory.add_pickaxe()
	queue_free()
