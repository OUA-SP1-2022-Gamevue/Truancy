extends ActorBase

var origin = Vector2()
#speed variable set as constant, this controls move speed
var direction = 1
export var stray = 60 #how far they will stray from the origin

func _ready():
	$Sprite.rotation_degrees = 90
	origin.x = position.x
	origin.y = position.y
	velocity.y = move_speed

func _physics_process(delta):
	move_and_slide(velocity * direction)
	if origin.y <= position.y-stray:
		direction = -1
		$Sprite.rotation_degrees = 270
	elif origin.y >= position.y+stray:
		direction = 1
		$Sprite.rotation_degrees = 90
