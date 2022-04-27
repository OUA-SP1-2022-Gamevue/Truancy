extends Button


export (String, FILE) var next_scene: = ""

func _on_button_up() -> void:
	get_tree().paused = false
	
	#Queue up the next track
	MusicController.queueTrack("res://Game/Assets/Audio/Level1S1.mp3")
	
	#Changing scenes
	get_tree().change_scene(next_scene)
