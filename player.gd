extends Node2D

@export var debug = false

var move_distance = 50 # Move distance in pixels

var wall_collision_left = false
var wall_collision_right = false
var wall_collision_up = false
var wall_collision_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2.ZERO
	if Input.is_action_just_pressed("move_left") && !wall_collision_left:
		direction.x = -1
	if Input.is_action_just_pressed("move_right") && !wall_collision_right:
		direction.x = 1
	if Input.is_action_just_pressed("move_up") && !wall_collision_up:
		direction.y = -1
	if Input.is_action_just_pressed("move_down") && !wall_collision_down:
		direction.y = 1
	
	position += direction * move_distance

func _physics_process(_delta):
	check_wall_collisions()

func check_wall_collisions():
	var space_state = get_world_2d().direct_space_state
	var wall_collision_mask = 0b00000000_00000000_00000000_00000001

	var left_target_position  = global_position + (Vector2.LEFT * move_distance)
	var right_target_position = global_position + (Vector2.RIGHT * move_distance)
	var up_target_position    = global_position + (Vector2.UP * move_distance)
	var down_target_position  = global_position + (Vector2.DOWN * move_distance)
	
	var left_query  = PhysicsRayQueryParameters2D.create(global_position, left_target_position,  wall_collision_mask, [self])
	var right_query = PhysicsRayQueryParameters2D.create(global_position, right_target_position, wall_collision_mask, [self])
	var up_query    = PhysicsRayQueryParameters2D.create(global_position, up_target_position,    wall_collision_mask, [self])
	var down_query  = PhysicsRayQueryParameters2D.create(global_position, down_target_position,  wall_collision_mask, [self])
	
	var left_result  = space_state.intersect_ray(left_query)
	var right_result = space_state.intersect_ray(right_query)
	var up_result    = space_state.intersect_ray(up_query)
	var down_result  = space_state.intersect_ray(down_query)

	wall_collision_left  = left_result.has("collider")
	wall_collision_right = right_result.has("collider")
	wall_collision_up    = up_result.has("collider")
	wall_collision_down  = down_result.has("collider")

	if (debug):
		print(
			"left: " + str(wall_collision_left)
			+ ", right: " + str(wall_collision_right)
			+ ", up: " + str(wall_collision_up)
			+ ", down: " + str(wall_collision_down)
		)
