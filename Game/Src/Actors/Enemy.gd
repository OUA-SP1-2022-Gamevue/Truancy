extends KinematicBody2D
class_name Enemy


export var move_speed := 100 #How fast the enemy is
export var patrol_range := 50 #How far the enemy will stray from their origin
export(int,"Down","Up","Right","Left") var direction #The enemy's starting direction.
export(int,"Idle","Patrol") var state #The enemy's starting state.


onready var vision_cone = $VisionCone
onready var origin = Vector2(get_position()) #Store's starting Coordinates
onready var ai = $AI


func _ready():
	#Turns on the vision cone's visibility, allowing it to be turned off in the editor.
	vision_cone.visible = true 
	#calls the intialise function of the AI node using itself as the parameter.
	ai.initialise(self)
