extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _player = $AudioStreamPlayer


func play(track_url : String):
	var track = load(track_url)
	_player.stream = track
	_player.play()
	pass

func stop():
	_player.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
