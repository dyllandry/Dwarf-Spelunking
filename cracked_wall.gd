extends Node2D


func _on_static_body_2d_interacted():
	if (PlayerInventory.get_pickaxes() > 0):
		PlayerInventory.remove_pickaxe()
		queue_free()
