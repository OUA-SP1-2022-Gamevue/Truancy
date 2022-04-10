extends Node2D


#Foundations of a couple of enum state machines for the AI to respond to.
enum Direction{
	DOWN,
	UP,
	RIGHT,
	LEFT
}
enum State{
	IDLE,
	PATROL
}

var direction :int = -1
var state :int = -1 setget set_state
var actor: KinematicBody2D = null #The object the AI script will be attached too.
var patrol_range :int = -1
var move_speed :int = 0
var velocity = Vector2.ZERO
var origin = Vector2.ZERO


func _physics_process(delta: float) -> void:
	#getting direction vectors for move and slide and rotating appropriately.
	match direction:
		Direction.DOWN:
			velocity.y = 1
			actor.global_rotation_degrees = 90
		Direction.UP:
			velocity.y = -1
			actor.global_rotation_degrees = 270
		Direction.RIGHT:
			velocity.x = 1
			actor.global_rotation_degrees = 0
		Direction.LEFT:
			velocity.x = -1
			actor.global_rotation_degrees = 180
	match state:
		#Tells the actor to move if it's in the Patrol state.
		State.PATROL:
			velocity = velocity.normalized()
			actor.move_and_slide(velocity * move_speed)
			check_if_end_of_patrol_range()


#Takes the enemy as a parameter then takes some values to use later.
#This allows the enemy to be called with just "actor"
func initialise(actor: KinematicBody2D):
	self.actor = actor
	self.direction = actor.direction
	self.state = actor.state
	self.patrol_range = actor.patrol_range
	self.move_speed = actor.move_speed
	self.origin = actor.origin
	

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

#Function just checks if the enemy has strayed too far from its origin and turns it around if it has.
func check_if_end_of_patrol_range():
	if origin.x <= actor.position.x-patrol_range:
		flip_direction()
	elif origin.x >= actor.position.x+patrol_range:
		flip_direction()
	if origin.y <= actor.position.y-patrol_range:
		flip_direction()
	elif origin.y >=actor.position.y+patrol_range:
		flip_direction()

#Pre-setting up this setter to allow extra things to occur when the state changes later.
func set_state(new_state):
	state = new_state

#This function calls the _flip_direction function
#when the enemy collides with a wall or another enemy.
func _on_BodyChecker_body_entered(body: Node):
	if body.get_collision_layer() == 2 or body.get_collision_layer() == 4:
		if body != actor:
			flip_direction()
	if body.has_method("lose_game"):
		body.lose_game()
