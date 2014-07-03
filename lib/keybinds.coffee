@keybinds = ->
	document.onkeydown = (e) ->
		console.log e.keyCode
		switch e.keyCode
			when 81 # -> Q button
				e.preventDefault()
				unmuteLocalMic()
			when 65 # -> A button, gets called when button is released
				e.preventDefault()
			when 39 # -> Right key
				e.preventDefault()
				nextScreen()
			when 37 # -> Left key
				e.preventDefault()
				nextScreen()

	document.onclick = ->
		if window.isFullscreen
			unmuteLocalMic()
		toggleFullScreen()

	document.body.addEventListener('touchmove', (e) -> nextScreen())

# Disable audio tracks on the localstream and remove timer
@muteLocalMic = ->
	window.webrtc.webrtc.localStream.getAudioTracks()[0].enabled = false
	setScreenReadyToTakeOver Session.get('selectedScreen')._id
	setScreenReadyToTakeOver Session.get('currentlyWatching')
	$("#timer").remove()

# Enable audio tracks on the localstream and start timer
@unmuteLocalMic = ->
	Meteor.clearTimeout(window.timer)
	window.webrtc.webrtc.localStream.getAudioTracks()[0].enabled = true
	timerAnimation()
	window.timer = Meteor.setTimeout(
		muteLocalMic
	, 20000
	)
	setScreenNotReadyToTakeOver Session.get('selectedScreen')._id
	setScreenNotReadyToTakeOver Session.get('currentlyWatching')

# When user taps enable fullscreen
@toggleFullScreen = ->
	elem = document.getElementById('container')
	if elem.requestFullscreen then elem.requestFullscreen()
	if elem.msRequestFullscreen then elem.msRequestFullscreen()
	if elem.mozRequestFullScreen then elem.mozRequestFullScreen()
	if elem.webkitRequestFullscreen then elem.webkitRequestFullscreen()
	window.isFullscreen = true

# Animating the timer width to give users feedback for how long they can talk
@timerAnimation = ->
	Meteor.clearTimeout(window.animationTimer)
	window.number = 100
	$("#container").append('<div id="timer"></div>')
	$("#timer").width(number + "%")
	window.animationTimer = Meteor.setInterval(
		animate
	, 100
	)

@animate = ->
	window.number -= 0.5
	$("#timer").width(number + "%")

# For testing purposes
@unmuteForever = ->
	window.webrtc.webrtc.localStream.getAudioTracks()[0].enabled = true