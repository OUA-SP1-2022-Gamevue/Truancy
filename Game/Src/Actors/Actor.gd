extends KinematicBody2D
#Planning on making the player and enemies all connect to this 
#Actor class later, right now just extending the movespeed and
#kinematicbody
class_name ActorBase

var velocity = Vector2()
export var move_speed = 100
