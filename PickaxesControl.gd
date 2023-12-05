extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerInventory.pickaxes_set.connect(_on_player_inventory_pickaxes_set)


func _on_player_inventory_pickaxes_set(pickaxes):
	$PickaxesLabel.text = str(pickaxes)

