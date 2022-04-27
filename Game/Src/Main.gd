extends Node2D


onready var camera: = $Camera2D
onready var player: Player = $Player

func _ready() -> void:
	#setting the camera's transform to the players
	player.set_to_player_transform(camera.get_path())



##Bit of a mess, but this is probably the best place to do this.
#There are a bunch of detectors throughout the level, when the player enters them,
#it'll fire a signal here, and we can queue up some music appropriate for the zone.

func _Zone1Detector_body_entered(body):
	#Checking if the thing that collided is the player
	if body is Player:
		#if so, let's queue up music for Zone1
		MusicController.queueTrack("res://Game/Assets/Audio/Level1S1.mp3")
	pass # Replace with function body.

#Same, for all other zones
func _Zone2Detector_body_entered(body):
	if body is Player:
		MusicController.queueTrack("res://Game/Assets/Audio/Level1S2.mp3")
	pass # Replace with function body.


func _Zone3Detector_body_entered(body):
	if body is Player:
		MusicController.queueTrack("res://Game/Assets/Audio/Level1S3.mp3")
	pass # Replace with function body.


func _Zone4Detector_body_entered(body):
	if body is Player:
		MusicController.playTrack("res://Game/Assets/Audio/Level1S4.mp3")
	pass # Replace with function body.


func _Zone0Detector_body_entered(body):
	if body is Player:
		MusicController.queueTrack("res://Game/Assets/Audio/Level1S0.mp3")
	pass # Replace with function body.
