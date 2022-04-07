extends ActorBase

var origin = Vector2()
export(int,"Still","Down","Up","Right","Left") var direction
export var stray = 60 #how far they will stray from the origin


func _ready():
	origin.x = position.x
	origin.y = position.y
	_get_dir()
		
func _physics_process(delta):
	_get_dir()
	move_and_slide(velocity)
	if origin.y <= position.y-stray:
		_get_flip()
	elif origin.y >= position.y+stray:
		_get_flip()
	if origin.x <= position.x-stray:
		_get_flip()
	elif origin.x >= position.x+stray:
		_get_flip()

func _get_dir():
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
		
func _get_flip():
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

func _on_Area2D_body_entered(body):
	if body.name == "TileMap" or body.get_collision_layer() == 2 or body.get_collision_layer() == 1:
		_get_flip()
	#if body.name == "Player":
	#	get_tree().change_scene("res://Game/Src/Levels/TestLevel.tscn")
