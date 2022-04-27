extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.queueTrack("res://Game/Assets/Audio/menu.mp3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
