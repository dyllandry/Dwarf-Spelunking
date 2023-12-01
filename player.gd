extends Node2D

var move_distance = 50 # Move distance in pixels

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2.ZERO
	if Input.is_action_just_pressed("move_right"):
		direction.x = 1
	if Input.is_action_just_pressed("move_left"):
		direction.x = -1
	if Input.is_action_just_pressed("move_up"):
		direction.y = -1
	if Input.is_action_just_pressed("move_down"):
		direction.y = 1
	
	position += direction * move_distance
