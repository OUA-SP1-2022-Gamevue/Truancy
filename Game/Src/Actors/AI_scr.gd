class_name AI
extends Node2D


#Foundations of a couple of finite state machines for the AI to respond to.
enum Direction{
	DOWN,
	UP,
	RIGHT,
	LEFT,
}
enum{
	IDLE,
	PATROL, #unsure on what to call these two states.
	PATHING, #unsure on what to call these two states.
}

var direction :int = -1
var state :int = -1 setget set_state
var actor: Enemy = null #The object the AI script will be attached too.
var patrol_range :int = -1
var move_speed :int = 0
var velocity: = Vector2.ZERO
var position_array: = PoolVector2Array()
var amount_of_targets: = 0
var current_target: = 0


func _physics_process(_delta: float) -> void:
	match state:
		#Tells the actor to move if it's in the Patrol state.
		PATROL:
			handle_direction_state()
			velocity = velocity.normalized()
			velocity *= move_speed
			velocity = actor.move_and_slide(velocity)
			
			check_if_end_of_patrol_range()
			
		IDLE:
			handle_direction_state()
			
		PATHING:
			if !actor.check_if_reached_position(position_array[current_target]):
				actor.rotate_toward(position_array[current_target])
				velocity = actor.vector_speed_toward(position_array[current_target])
				velocity = actor.move_and_slide(velocity)
			else:
				current_target = current_target+1 if amount_of_targets > current_target else 0
				
		_:
			print(actor)
			print("has entered an invalid state.")

#Takes the enemy as a parameter then takes some values to use later.
#This allows the enemy to be called with just "actor"
func initialise(new_actor: KinematicBody2D):
	self.actor = new_actor
	direction = actor.direction
	patrol_range = actor.patrol_range
	move_speed = actor.move_speed
	position_array = actor.position_array
	amount_of_targets = position_array.size()-1
	self.state = actor.state

#Flips the direction to the opposite one.
func flip_direction():
	match direction:
		Direction.DOWN:
			direction = Direction.UP
		Direction.UP:
			direction = Direction.DOWN
		Direction.RIGHT:
			direction = Direction.LEFT
		Direction.LEFT:
			direction = Direction.RIGHT


#not a fan of this implementation can probably merge this with the patrol range
#checker.
func handle_direction_state():
	match direction:
		Direction.RIGHT:
			velocity.x = 1
			var new_vector: Vector2 = actor.position
			new_vector.x += 10
			actor.rotate_toward(new_vector)
		Direction.LEFT:
			velocity.x = -1
			var new_vector: Vector2 = actor.position
			new_vector.x -= 10
			actor.rotate_toward(new_vector)
		Direction.DOWN:
			velocity.y = 1
			var new_vector: Vector2 = actor.position
			new_vector.y += 10
			actor.rotate_toward(new_vector)
		Direction.UP:
			velocity.y = -1
			var new_vector: Vector2 = actor.position
			new_vector.y -= 10
			actor.rotate_toward(new_vector)
		_:
			print(actor)
			print("has entered an invalid direction.")


#Function just checks if the enemy has strayed too far from its origin and
#turns it around if it has.
func check_if_end_of_patrol_range():
	if position_array[0].x <= actor.position.x-patrol_range:
		flip_direction()
	elif position_array[0].x >= actor.position.x+patrol_range:
		flip_direction()
	if position_array[0].y <= actor.position.y-patrol_range:
		flip_direction()
	elif position_array[0].y >=actor.position.y+patrol_range:
		flip_direction()


#Pre-setting up this setter to allow extra things to occur when the state changes later.
func set_state(new_state: int) -> void:
	state = new_state


#This function calls the flip_direction function.
#when the enemy collides with a wall or another enemy.
func handle_body_collision_response(body: Node) -> void:
	if body is Enemy or body is TileMap:
		if body != actor:
			flip_direction()
	if body.has_method("lose_game"):
		body.lose_game()
