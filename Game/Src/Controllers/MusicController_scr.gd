extends Control


#First we're setting up our instance of an audio player, called _player
onready var _player = $AudioStreamPlayer

#Here we will keep track of the current track being played, stored as the resource URL in a string
var _currentTrack : String
var _queuedTrack : String

#eh I'll comment the rest later
var isMuted = false

#Internal fuctions:

func _play(track_url : String):
	if !isMuted:
		var track = load(track_url)
		_player.stream = track
		_player.play()
		pass

func stop():
	_player.stop()
	
	
	



##External Functions:

func queueTrack( nextTrack : String ):
	_queuedTrack = nextTrack
	if (_currentTrack == ""):
		_currentTrack = _queuedTrack
		_play(_currentTrack)

func PlayTrack( nextTrack : String ):
	_queuedTrack = ""
	_currentTrack = nextTrack
	_play(_currentTrack)


func progressQueue():
	##to be called once current playback ends, progress to next song in queue
	pass
	
	
#External Mute access
func mute():
	isMuted = true
	stop()

func toggleMute():
	print("Toggling Mute")
	isMuted = !isMuted
	if isMuted:
		print("Stopping")
		stop()
	else:
		print("Can't stop the vibes!")
		##check for curre
		pass



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Not sure if there's anything to use this for, but can't hurt to have it


#If anyone needs to use the following, you're doing it wrong:

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
