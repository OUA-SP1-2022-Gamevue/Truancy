extends KinematicBody2D

#speed variable set as constant, this controls move speed
var SPEED = 1

#y axis patrol
func _physics_process(delta):
	
	#this starts the patrol
	position.y += SPEED
	
	#the npc moves along the y axis (up/down)
	if position.y >= 100:
		SPEED -= 1
	if position.y <= 0:
		SPEED += 1
