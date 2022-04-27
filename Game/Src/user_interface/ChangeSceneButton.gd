extends Button


export (String, FILE) var next_scene: = ""

func _on_button_up() -> void:
	get_tree().paused = false
	#Killing menu screen music, then immediatly playing the first level's music
	MusicController.stop()
	MusicController.PlayTrack("res://Game/Assets/Audio/level1a1.mp3")
	get_tree().change_scene(next_scene)
