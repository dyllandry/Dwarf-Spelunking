extends Node


signal pickaxes_set(pickaxes)


var _pickaxes = 0


func get_pickaxes():
    return _pickaxes


func add_pickaxe():
    _pickaxes += 1
    pickaxes_set.emit(_pickaxes)


func remove_pickaxe():
    _pickaxes -= 1
    pickaxes_set.emit(_pickaxes)