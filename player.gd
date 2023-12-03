extends Node2D

var move_distance = 50 # Move distance in pixels

var wall_collision_left  = false
var wall_collision_right = false
var wall_collision_up    = false
var wall_collision_down  = false

var interactable_left  = null
var interactable_right = null
var interactable_up    = null
var interactable_down  = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2.ZERO
	if Input.is_action_just_pressed("move_left")  && !wall_collision_left:
		direction.x = -1
	if Input.is_action_just_pressed("move_right") && !wall_collision_right:
		direction.x = 1
	if Input.is_action_just_pressed("move_up")    && !wall_collision_up:
		direction.y = -1
	if Input.is_action_just_pressed("move_down")  && !wall_collision_down:
		direction.y = 1
	
	position += direction * move_distance

	if Input.is_action_just_pressed("move_left")  && facing_interactable('left'):
		interactable_left.interact()
	if Input.is_action_just_pressed("move_right") && facing_interactable('right'):
		interactable_right.interact()
	if Input.is_action_just_pressed("move_up")    && facing_interactable('up'):
		interactable_up.interact()
	if Input.is_action_just_pressed("move_down")  && facing_interactable('down'):
		interactable_down.interact()


func _physics_process(_delta):
	check_wall_collisions()
	check_interactable()


func check_wall_collisions():
	var wall_collision_mask = 0b00000000_00000000_00000000_00000001
	
	var left_result  = ray('left',  wall_collision_mask)
	var right_result = ray('right', wall_collision_mask)
	var up_result    = ray('up',    wall_collision_mask)
	var down_result  = ray('down',  wall_collision_mask)

	wall_collision_left  = left_result.has("collider")
	wall_collision_right = right_result.has("collider")
	wall_collision_up    = up_result.has("collider")
	wall_collision_down  = down_result.has("collider")


func facing_interactable(direction):
	if (direction == 'left'  && interactable_left != null  && interactable_left.has_method('interact')):
		return true
	if (direction == 'right' && interactable_right != null && interactable_right.has_method('interact')):
		return true
	if (direction == 'up'    && interactable_up != null    && interactable_up.has_method('interact')):
		return true
	if (direction == 'down'  && interactable_down != null  && interactable_down.has_method('interact')):
		return true


func check_interactable():
	interactable_left  = null
	interactable_right = null
	interactable_up    = null
	interactable_down  = null

	var interactable_collision_mask = 0b00000000_00000000_00000000_00000010	
	var left_result  = ray('left',  interactable_collision_mask)
	var right_result = ray('right', interactable_collision_mask)
	var up_result    = ray('up',    interactable_collision_mask)
	var down_result  = ray('down',  interactable_collision_mask)

	if (left_result.has("collider")):
		interactable_left = left_result.collider
	if (right_result.has("collider")):
		interactable_right = right_result.collider
	if (up_result.has("collider")):
		interactable_up = up_result.collider
	if (down_result.has("collider")):
		interactable_down = down_result.collider


func ray(direction, mask):
	var space_state = get_world_2d().direct_space_state

	var target_position = global_position
	if (direction == 'left'):
		target_position += Vector2.LEFT * move_distance
	if (direction == 'right'):
		target_position += Vector2.RIGHT * move_distance
	if (direction == 'up'):
		target_position += Vector2.UP * move_distance
	if (direction == 'down'):
		target_position += Vector2.DOWN * move_distance
	
	var query = PhysicsRayQueryParameters2D.create(global_position, target_position, mask, [self])
	
	var result = space_state.intersect_ray(query)
	
	return result
