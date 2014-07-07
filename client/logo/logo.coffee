Template.logo.rendered = -> $(".Qportal-logo").animate({'margin-top' : '10px'})

@addLogoToStreamView = ->
	$("#container").prepend('
		<div class="Qportal-logo">
			<img class="druppel" src="druppel.png">
			<img class="druppelgroen" src="druppelgroen.png" style="opacity: 0;">
			<img class="swirl" src="swirl.png">
			<img class="swirlglow" src="swirlglow.png" style="visibility: hidden;">
			<img class="Q" src="Q.png">
			<img class="Qgroen" src="Qgroen.png" style="opacity: 0;">
		</div>
		')

	$(".Qportal-logo").animate({'margin-top' : '10px'}, 400, 'swing', => 
		$(".Qportal-logo").css('left', '10px')
		$(".Qportal-logo").css('top', '10px')
		)


@removeLogo = -> 
	$(".Qportal-logo").animate({'margin-top' : '-100px'})
	$(".Qportal-logo").remove()
	$(".Qportal-logo").css('margin-top': '10px')