extends Area2D


func _on_VisionCone_body_entered(body: Node) -> void:
	#checks to see if the collision body has method lose_game
	if body.has_method("lose_game"):
		#calls the player's lose_game function
		body.lose_game()
