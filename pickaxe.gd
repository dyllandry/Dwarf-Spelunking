extends Node2D


func _on_static_body_2d_interacted():
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.add_pickaxe()
	queue_free()
