extends Control

#First we're setting up our instance of an audio player, called _player
onready var _player = $AudioStreamPlayer

#Here we will keep track of the current track being played, stored as the resource URL in a string
var _currentTrack : String
var _queuedTrack : String

#Now a bool to check if we are currently muted or not:
var _isMuted = false

#Internal fuctions:
#I've pulled a sneaky one on you, so far everything has had a "_" before the name
#That's because they're internal, and we don't want other classes playing with them,
#We want everything else to use getters and setters so we never loose track of our state

#This is an internal function that will play the _currentTrack,
#it should only be called in cases where we have just set _currentTrack
func _play():
	#check if we are not(!) muted, otherwise do nothing
	if !_isMuted:
		#loading the track at the URL
		var track = load(_currentTrack)
		#telling the player to stream in the file
		_player.stream = track
		#now playing it
		_player.play()
		pass

#After a current track is finished, this needs to check if there is anything queued,
#And if so, move it forwards into _currentTrack and play it, otherwise, do nothing
#other than repeat _currentTrack
func progressQueue():
	##to be called once current playback ends, progress to next song in queue
	#Will also be called if we've just been muted, in such cases we will advance the queue reguardless
	
	#Checking if there's something in the queue
	if _queuedTrack != "":
		#if so move it to _currentTrack...
		_currentTrack = _queuedTrack
		#and clear the queue
		_queuedTrack = ""
		#now call _play, it'll handle if we're muted
		_play()
	#otherwise, if we have a current track, play the current track
	#(this gives us looping back, which we need to disable on a per-file basis, otherwise the audio player won't fire us a signal)
	elif _currentTrack != "":
		_play()
	#just in case we don't have anything availble:
	pass

##External Functions:
#These are the only things we want to expose to the outside world, to make things nice and clean.
#We'll keep track of everything in here, so all anything else needs to worry about is if it wants to queue a song,
#Or if it wants it to play immediatly

#This one's for queueing a track
func queueTrack( nextTrack : String ):
	#we get nextTrack from the caller, and set it to the queue, overwriting whatever's there
	_queuedTrack = nextTrack
	#We check if there's anything in _currentTrack, and if not, we assign the queue to it, play it, and clear the queue
	if (_currentTrack == ""):
		_currentTrack = _queuedTrack
		_queuedTrack = ""
		_play()

#We clear the queue, and play the track we were passed
func playTrack( nextTrack : String ):
	_queuedTrack = ""
	_currentTrack = nextTrack
	_play()

#does exactly what it says on the box
func stop():
	_player.stop()

#External Mute access
#If something calls this, it mutes itself instantly
func mute():
	_isMuted = true
	stop()

#Toggle's mute. Slightly redundant, but this one is too sleepy to determine what is needed, please ignore it.
func toggleMute():
	#Invert the mute bool
	_isMuted = !_isMuted
	#check if we're now muted, if so, stop
	if _isMuted:
		stop()
	#Otherwise, resume what we had.
	else:
		if _currentTrack != "":
			_play()
		#If we had nothing, but something is queued, bring it in and play
		elif _queuedTrack != "":
			_currentTrack = _queuedTrack
			_queuedTrack = ""
			_play()
		pass
		
#Something so other scripts can check if we're muted or not
#returns a bool for easy access
func areWeMuted() -> bool:
	return _isMuted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Not sure if there's anything to use this for, but can't hurt to have it
	#we are currently dependant on the first scene that loads to kick things off,
	#or anything else that happens to have the occasion to queue some audio


#If anyone needs to use the following, you're doing it wrong:

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
