Template.portal.rendered = -> 
	window.onresize = ->
		verticalAlignRemoteVideo()
	
	window.setInterval -> 
		verticalAlignRemoteVideo()
	,1000

Template.portalStream.rendered = ->
	$(".site-wrapper").remove()
	$("body").append('<div id="container"></div>')
	$("#container").append('<div id="remotesVideos"></div>')
	$("#container").append('<video id="localVideo"></video>')
	removeLogo()
	addLogoToStreamView()

	webrtc = new SimpleWebRTC
		localVideoEl: 'localVideo'
		remoteVideosEl: 'remotesVideos'
		autoRequestMedia: true

	window.webrtc = webrtc
	webrtc.on('readyToCall', -> 
		webrtc.joinRoom(Session.get("selectedScreen").room)
		setDefaultCurrentlyWatching() # Set our currently watching
		remoteScreenConnectWatcher() # Set our observer for when our room changes (so it switches to the other screen)
	)
	webrtc.on('videoAdded', -> verticalAlignRemoteVideo())
	webrtc.on('localStream', ->
		muteLocalMic()
		screenStartedSession(Session.get('selectedScreen')._id, window.webrtc.connection.socket.sessionid)
		keybinds()
	)
	webrtc.on('videoRemoved', -> console.log this)
	Session.set('currentRoom', Session.get("selectedScreen").room)

Template.selectScreens.helpers
	locations: -> locations.find()
	screens: -> screens.find({location: this._id})

Template.selectScreens.events
	'click li': (e) -> 
		# When starting session set our own room back to default - and set session variable 
		updateScreenToDefaultRoomName(this._id)
		Session.set('selectedScreen', screens.find(this._id).fetch()[0])

Template.portal.userSelectedScreen = -> 
	if Session.get 'selectedScreen'
		false
	else
		true

# Method to align the remote video
@verticalAlignRemoteVideo = ->
	$("#remotesVideos video").css('width', window.innerWidth + "px")
	videoHeight = $("#remotesVideos video").height()
	windowHeight = window.innerHeight
	negativeMargin = (videoHeight - windowHeight) * -1
	$("#remotesVideos video").css('margin-top', negativeMargin + "px")

# Gets called by pressing Right/Left button on keyboard or swipe on tablet
@nextScreen = ->
	# We iterate over this array to find the nextscreen
	window.screensArray = []
	buildIndexOfScreens()

	# When we go to the next screen - set our currentlywatching back to default
	updateScreenToDefaultRoomName Session.get('currentlyWatching')
	setScreenReadyToTakeOver Session.get('currentlyWatching')

	# Update our next screen to match our temporary room
	updateScreensToMatchRoom getNextScreenId()
	Session.set 'currentlyWatching', getNextScreenId()

# Observing when our room changes, then join that new room
@remoteScreenConnectWatcher = ->
	query = screens.find(Session.get("selectedScreen")._id)
	query.observeChanges
		changed: (id, field) ->
			if field.room
				console.log("updating room", id)
				muteLocalMic()
				window.webrtc.leaveRoom()
				# Want to check if screen is readyToTakeOver
				window.webrtc.joinRoom(field.room)

	watcher = screens.find()
	watcher.observeChanges
		changed: (id, field) ->
			if window.webrtc.webrtc.peers.length 
				console.log "nobody connected"