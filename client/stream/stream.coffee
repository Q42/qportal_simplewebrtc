webrtc = null;
Template.stream.rendered = -> 
	webrtc = new SimpleWebRTC
		localVideoEl: 'localVideo'
		remoteVideosEl: 'remotesVideos'
		autoRequestMedia: true

	webrtc.on('readyToCall', -> webrtc.joinRoom('test'))