@insertNewLocation = (locationName) -> locations.insert(name: locationName)
@updateLocationName = (locationId, locationName) -> locations.update(locationId, {$set: {name: locationName}})
@removeLocation = (locationId) -> locations.remove(locationId)
@insertNewScreen = (screenName) -> screens.insert(name: screenName)
@updateScreenName = (screenId, screenName) -> screens.update(screenId, {$set: {name: screenName}})
@updateRoom = (screenId, roomName) -> screens.update(screenId, {$set: {room: roomName}})
@updateScreenLocation = (screenId, screenLocation) -> screens.update(screenId, {$set: {location: screenLocation}})
@setScreenNotReadyToTakeOver = (screenId) -> screens.update(screenId, {$set:{readyToTakeOver: false}})
@setScreenReadyToTakeOver = (screenId) -> screens.update(screenId, {$set:{readyToTakeOver: true}})
@setDefaultRoomName = (screenId, roomName) -> screens.update(screenId, {$set: {room: roomName, defaultRoomName: roomName}})
@screenStartedSession = (screenId, sessionId) -> screens.update(screenId, {$set: {readyToTakeOver: true, isTalking: false, sessionId: sessionId}})

@updateScreenToDefaultRoomName = (screenId) -> 
	defaultRoomName = screens.find(screenId).fetch()[0].defaultRoomName
	screens.update(screenId, {$set: {room: defaultRoomName}})

@isScreenReadyToTakeOver = (screenId) -> 
	if screens.find(screenId).fetch()[0].readyToTakeOver
		return true
	else
		return false

@removeScreenLocation = (screenId) -> screens.update(screenId, {$set: {location: null}})
@removeScreen = (screenId) -> screens.remove(screenId)

@clearScreenSelection = (screenId) ->
	$("#" + screenId).css('background-color', 'none')
	Session.set "selectedScreen", null
	$(".locationHolder").css('border', 'solid 1px #CCC')

@matchScreens = ->
	for i in [0...$(".screenHolder").find("ol")[0].children.length]
		setDefaultRoomName $($(".screenHolder").find("ol")[0].children[i]).attr("class"), $($(".screenHolder").find("ol")[0].children[i]).attr("class")
		setDefaultRoomName $($(".screenHolder").find("ol")[1].children[i]).attr("class"), $($(".screenHolder").find("ol")[0].children[i]).attr("class")