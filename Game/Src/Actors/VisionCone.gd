extends Area2D


func _ready() -> void:
	#Turns on the vision cone's visibility, allowing it to be turned off in the editor.
	visible = true


func _on_VisionCone_body_entered(body: Node) -> void:
	#checks to see if the collision body has method lose_game
	if body.has_method("lose_game"):
		#calls the player's lose_game function
		body.lose_game()
