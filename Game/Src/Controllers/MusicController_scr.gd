extends Control


#First we're setting up our instance of an audio player, called _player
onready var _player = $AudioStreamPlayer

#Here we will keep track of the current track being played, stored as the resource URL in a string
var currentTrack : String
var queuedTrack : String

#eh I'll comment the rest later
var isMuted = false


func _play(track_url : String):
	if !isMuted:
		var track = load(track_url)
		_player.stream = track
		_player.play()
		pass

func stop():
	_player.stop()
	
func mute():
	isMuted = true
	stop()

func toggleMute():
	isMuted = !isMuted
	if isMuted:
		stop()
	else:
		##read current queue'd track, play
		pass

func queueTrack( nextTrack : String ):
	queuedTrack = nextTrack
	if (currentTrack == ""):
		currentTrack = queuedTrack
		_play(currentTrack)

func PlayTrack( nextTrack : String ):
	queuedTrack = ""
	currentTrack = nextTrack
	_play(currentTrack)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
