extends Button


export (String, FILE) var next_scene: = ""

func _on_button_up() -> void:
	get_tree().paused = false
	
	
	#Killing menu screen music, then immediatly playing the first level's music
	#Not sure if this is nececary, testing doesn't seem to show it is, but let's be safe
	MusicController.stop()
	MusicController.playTrack("res://Game/Assets/Audio/level1a1.mp3")
	
	#Changing scenes
	get_tree().change_scene(next_scene)
