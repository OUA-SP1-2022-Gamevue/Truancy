extends ActorBase #Actor.gd

#A Vector to store the starting co-ordinates of the enemy.
onready var origin = Vector2(get_position())
#Starting direction of the enemy (0 = Still, 1 = Down, 2 = Up, 3 = Right, 4 = Left)
export(int,"Still","Down","Up","Right","Left") var direction
#How far the enemy will stray from their origin
export var stray = 60

func _ready():
	_get_velocity()
		
func _physics_process(_delta: float) -> void:
	
	#Code block calls the flip direction function whenever the enemy is 
	#'stray' pixels from their origin.
	if origin.y <= position.y-stray:
		_flip_direction()
	elif origin.y >= position.y+stray:
		_flip_direction()
	if origin.x <= position.x-stray:
		_flip_direction()
	elif origin.x >= position.x+stray:
		_flip_direction()
	_get_velocity()
	move_and_slide(velocity)

#This function will set the velocity and rotation of the enemy to their appropriate
#direction.
func _get_velocity():
	#1 = Down, 2 = Up, 3 = Right, 4 = Left
	if direction == 1:
		$Sprite.rotation_degrees = 90
		$VisionCone.rotation_degrees = 90
		velocity.y = move_speed
	elif direction == 2:
		$Sprite.rotation_degrees = 270
		$VisionCone.rotation_degrees = 270
		velocity.y = -move_speed
	elif direction == 3:
		$Sprite.rotation_degrees = 0
		$VisionCone.rotation_degrees = 0
		velocity.x = move_speed
	elif direction == 4:
		$Sprite.rotation_degrees = 180
		$VisionCone.rotation_degrees = 180
		velocity.x = -move_speed

func _flip_direction():
	#1 = Down, 2 = Up, 3 = Right, 4 = Left
	if direction == 1:
		direction = 2
	elif direction == 2:
		direction = 1
	elif direction == 3:
		direction = 4
	elif direction == 4:
		direction = 3
	$Sprite.rotation_degrees -= 180
	$VisionCone.rotation_degrees -= 180

#This function calls the _flip_direction function
#when the enemy collides with a wall or another enemy.
func _on_Area2D_body_entered(body):
	if body.get_collision_layer() == 2 or body.get_collision_layer() == 4:
		_flip_direction()
	#calls the player's lose_game function should they collide.
	if body.name == "Player":
		body.lose_game()


func _on_VisionCone_body_entered(body):
	#calls the player's lose_game function should they collide.
	if body.name == "Player":
		body.lose_game()
