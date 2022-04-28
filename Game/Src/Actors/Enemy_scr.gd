class_name Enemy
extends KinematicBody2D


export var move_speed := 50 #How fast the enemy is
export var patrol_range := 50 #How far the enemy will stray from their origin
export(int,"Down","Up","Right","Left") var direction #The enemy's starting direction.
export(int,"Idle","Patrol","Pathing") var state #The enemy's starting state.


onready var position_array = PoolVector2Array([global_position]) #Store's starting Coordinates
onready var ai = $AI


func _ready():
	for child in get_children():
		if child is Position2D:
			position_array.append(child.global_position)
			child.queue_free()
	
	#calls the intialise function of the AI node using itself as the parameter.
	ai.initialise(self)


func rotate_toward(location: Vector2, rotate_speed: float = 0.1):
	rotation = lerp_angle(rotation, global_position.direction_to(location).angle(),rotate_speed)


func vector_speed_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * move_speed


func check_if_reached_position(location: Vector2) -> bool:
	return global_position.distance_to(location) < 2


func _on_BodyChecker_body_entered(body: Node):
	ai.handle_body_collision_response(body)
