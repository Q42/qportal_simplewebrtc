# Builds an array of all streams
@buildIndexOfScreens = ->
	for screen in screens.find().fetch()
		if screen._id isnt Session.get('selectedScreen')._id
			window.screensArray.push screen._id

# Returns the screen id of the next screen
@getNextScreenId = ->
	i = 0 
	nextScreenId = ""
	while i < window.screensArray.length
		if Session.get('currentlyWatching') is window.screensArray[i]
			if i+1 >= window.screensArray.length
				nextScreenId = window.screensArray[0]
				break
			else
				nextScreenId = window.screensArray[i+1]
				break
		i++
	return nextScreenId

# Sets the default currentlyWatching which is used to determine the next screen when we scroll through available screens
@setDefaultCurrentlyWatching = ->
	for screen in screens.find().fetch()
		if screen._id isnt Session.get('selectedScreen')._id and screen.room is Session.get('selectedScreen').room
			Session.set 'currentlyWatching', screen._id

@updateScreensToMatchRoom = (screenId) ->
	# If this screen is our default counterpart - set everything back to normal
	if screens.find(screenId).fetch()[0].defaultRoomName is Session.get('selectedScreen').defaultRoomName
		updateScreenToDefaultRoomName Session.get('selectedScreen')._id
		updateScreenToDefaultRoomName screens.find(screenId).fetch()[0]._id
		setScreenReadyToTakeOver Session.get('selectedScreen')._id
		setScreenReadyToTakeOver screens.find(screenId).fetch()[0]._id

	# If this screen is not our default counterpart - put the two in a temporary room !!!!!!UNLESS readyToTakeOver!!!!!
	else 
		updateRoom Session.get('selectedScreen')._id, "temproom"+Session.get('selectedScreen')._id
		updateRoom screenId, "temproom"+Session.get('selectedScreen')._id
		setScreenNotReadyToTakeOver Session.get('selectedScreen')._id
		setScreenNotReadyToTakeOver screenId
		console.log "updating room"

	# Update our session selectedScreen
	Session.set 'selectedScreen', screens.find(Session.get('selectedScreen')._id).fetch()[0]

@isItemInArray = (array, item) ->
	if item in array 
		true
	else 
		false