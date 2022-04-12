extends KinematicBody2D
class_name Player


export var speed := 150


onready var sprite = $Sprite


func _physics_process(_delta: float) -> void:
	#Reset the movement_direction vector.
	var movement_direction := Vector2.ZERO
	#This code block updates the movement_direction Vector based on the user's input.
	if Input.is_action_pressed("move_up"):
		movement_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		movement_direction.y += 1
	if Input.is_action_pressed("move_left"):
		movement_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		movement_direction.x += 1
	#Normalizes the Vector so the player doesn't move faster diagonally.
	movement_direction = movement_direction.normalized()
	#Inbuilt method that moves the player.
	move_and_slide(speed * movement_direction)
	
	#This rotates the sprite at the value of the mouse's position
	sprite.look_at(get_global_mouse_position())


#just resetting the game for now
func lose_game():
	get_tree().reload_current_scene()

func _close_game():
	get_tree().quit()
