extends ActorBase

func _physics_process(_delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	_get_dir()
	velocity = move_and_slide(velocity,Vector2(0,1))
	velocity.x = lerp(velocity.x,0,0.2)
	velocity.y = lerp(velocity.y,0,0.2)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("temp_close"):
		_close_game()

#Making this function as we might be able to set up cutscenes later to use it.
func _get_dir():
	if Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		velocity.x = move_speed
	elif Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		velocity.x = -move_speed
	if Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		velocity.y = move_speed
	elif Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_down"):
		velocity.y = -move_speed

func _close_game():
	get_tree().quit()
