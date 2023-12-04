extends Node2D


func _on_static_body_2d_interacted():
	if (PlayerInventory.pickaxes > 0):
		PlayerInventory.pickaxes -= 1
		queue_free()
