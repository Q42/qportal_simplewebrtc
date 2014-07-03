Template.admin.helpers
	hasLocations: -> 
		if locations.find().fetch().length > 0 
			true

	maximumNumberOfLocations: -> 
		if locations.find().fetch().length < 2
			true
		else
			false

Template.addLocation.events
	'click button': (e) -> 
		newLocationName = $("#newLocation").val()
		if newLocationName
			insertNewLocation newLocationName

Template.locationList.helpers 
	locations: -> locations.find()
	screens: -> screens.find({location: this._id})

Template.locationList.events
	'click h1': (e) ->
		if not Session.get("selectedScreen")?
			$("#" + this._id).find("h1").hide()
			$("#" + this._id).prepend('<input type="text" id="edit" class="form-control" placeholder="' + this.name + '" />')

	'input': (e) ->
		updateLocationName this._id, $("#" + this._id).find("input").val()

	'keydown': (e) ->
		if e.keyCode is 13
			$("#edit").remove()
			$("#" + this._id).find("h1").fadeIn()

	'click': (e) ->
		if Session.get("selectedScreen")?
			updateScreenLocation Session.get("selectedScreen")._id, this._id
			matchScreens()
			clearScreenSelection Session.get("selectedScreen")._id

	'click .glyphicon-remove-circle': (e) ->
		removeScreenLocation this._id

Template.addScreen.events
	'click button': (e) ->
		newScreen = $("#newScreen").val()
		if newScreen
			insertNewScreen newScreen
			$("#newScreen").val("")

Template.screenList.helpers screens: -> screens.find()

Template.screenList.events
	'click .glyphicon-remove-circle': (e) -> removeScreen this._id
	'click li': (e) -> 
		if this._id is Session.get("selectedScreen")?._id
			clearScreenSelection this._id
		else
			$("#" + this._id).css('background-color', '#CCC')
			$("#" + Session.get("selectedScreen")?._id).css('background-color', 'none', 'color', 'black')
			$(".locationHolder").css('border', 'solid 1px #000')
			Session.set "selectedScreen", this