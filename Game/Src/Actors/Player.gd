extends KinematicBody2D
class_name Player


export var speed := 120

onready var sprite = $Sprite
onready var footstep_player = $FootstepAudioPlayer


func _physics_process(_delta: float) -> void:
	#Reset the velocity vector.
	var velocity := Vector2.ZERO
	
	#This code block updates the velocity Vector based on the user's input.
	velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
		
	#Normalizes the Vector so the player doesn't move faster diagonally.
	velocity = velocity.normalized()
	
	#Calculating the velocity by multiplying the vector we get from input by
	#the speed variable. 
	#Changing the velocity to equal the output of move and slide will allow the
	#velocity vector to be (0,0) when colliding with a wall, which stops the
	#footsteps from playing while moving into a wall.
	velocity = velocity * speed
	velocity = move_and_slide(velocity)
	
	#This rotates the sprite at the value of the mouse's position
	sprite.look_at(get_global_mouse_position())
	
	#Just a quick way to play the footstep sound if the character is moving
	#I'm sure there's a more performant way to do this rather than running it
	#in the physics process, just here for concept now.
	if velocity != Vector2.ZERO and !footstep_player.playing:
		footstep_player.play()
	elif velocity == Vector2.ZERO:
		footstep_player.stop()


#just resetting the game for now
func lose_game():
	get_tree().reload_current_scene()
