extends Control


onready var scene_tree: = get_tree()
onready var pause_overlay: = $PauseOverlay


var pause: = false setget set_pause


func _ready() -> void:
	#Confining the mouse to the window.
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		self.pause = !pause
		scene_tree.set_input_as_handled()

func set_pause(value: bool) -> void:
	pause = value
	pause_overlay.visible = value
	scene_tree.paused = value
	#Confining and unconfining the mouse depnding on
	#the pause state.
	if value == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif value == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
