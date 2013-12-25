// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require social_stream-base
//= require social_stream-documents
//= require social_stream-events
//= require social_stream-linkser
//= require social_stream-presence
//= require_tree .


$(document).ready(function(){ 
  
	$('.resize').hover(
		function() {
			$(this).animate({width: 300});;
		},
		function() {
			$(this).animate({width: 250});
		}
	);
	
	$('.phrase1').hover(
		function() {
			$('#image1').animate({width: 300});;
		},
		function() {
			$('#image1').animate({width: 250});
		}
	);
	
	$('.phrase2').hover(
		function() {
			$('#image2').animate({width: 300});;
		},
		function() {
			$('#image2').animate({width: 250});
		}
	);
	
	$('.phrase3').hover(
		function() {
			$('#image3').animate({width: 300});;
		},
		function() {
			$('#image3').animate({width: 250});
		}
	);
	
	////////////////////////////////////////////////////
		var button = $('#loginButton');
		var box = $('#loginBox');
		var form = $('#loginForm');
		button.removeAttr('href');
		button.mouseup(function(login) {
			box.toggle();
			button.toggleClass('active');
		});
		form.mouseup(function() { 
			return false;
		});
		$(this).mouseup(function(login) {
			if(!($(login.target).parent('#loginButton').length > 0)) {
				button.removeClass('active');
				box.hide();
			}
		});
});//end $(document).ready(function()
