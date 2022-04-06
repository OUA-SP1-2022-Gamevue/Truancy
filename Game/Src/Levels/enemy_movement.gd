extends KinematicBody2D

var SPEED = 1

func _physics_process(delta):
	
	position.y += SPEED
	
	if position.y >= 100:
		SPEED -= 1
	if position.y <= 0:
		SPEED += 1
