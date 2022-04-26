extends Node2D


onready var camera: = $Camera2D
onready var player: Player = $Player

func _ready() -> void:
	#setting the camera's transform to the players
	player.set_to_player_transform(camera.get_path())
