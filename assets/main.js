// Setting Global JS variables
var currPage = window.location.pathname.substr(1, window.location.pathname.length);

findSelectedOption = function( parent ) {
	let currvalue = jQuery( parent ).val();
	let finds = jQuery( parent ).find( "option" ).filter( function() {
		return jQuery( this ).attr( "value" ) == currvalue;
	});
	if( finds.length > 0 ) {
		return finds[0];
	}
	return null;
}

jQuery(document).ready(function ($) {
	// set active menu
	// remove second & third replace, if not needed
	currSelectMenu = "menu_" + currPage.replace("/", "_submenu_").replace("/", "_submenu_").replace("/", "_submenu_");
	// console.log( "currSelectMenu ::: " + currSelectMenu );
	jQuery("#" + currSelectMenu).addClass("menu-active");


	// Back to top button
	$(window).scroll(function () {
		if ($(this).scrollTop() > 100) {
			$('.back-to-top').fadeIn('slow');
		} else {
			$('.back-to-top').fadeOut('slow');
		}
	});
	$('.back-to-top').click(function () {
		$('html, body').animate({
			scrollTop: 0
		}, 1500, 'easeInOutExpo');
		return false;
	});

	// Stick the header at top on scroll
	$("#header").sticky({
		topSpacing: 0,
		zIndex: '50'
	});

	// Intro background carousel
	$("#intro-carousel").owlCarousel({
		autoplay: true,
		dots: false,
		loop: true,
		animateOut: 'fadeOut',
		items: 1
		// responsive: {
		//   0: {
		//     items: 1
		//   },
		//   768: {
		//     items: 2
		//   },
		//   900: {
		//     items: 3
		//   }
		// }
	});

	// Initiate the wowjs animation library
	// new WOW().init();

	// Initiate superfish on nav menu
	$('.nav-menu').superfish({
		animation: {
			opacity: 'show'
		},
		speed: 400
	});

	// Mobile Navigation
	if ($('#nav-menu-container').length) {
		var $mobile_nav = $('#nav-menu-container').clone().prop({
			id: 'mobile-nav'
		});
		$mobile_nav.find('> ul').attr({
			'class': '',
			'id': ''
		});
		$('body').append($mobile_nav);
		$('body').prepend('<button type="button" id="mobile-nav-toggle"><i class="fa fa-bars"></i></button>');
		$('body').append('<div id="mobile-body-overly"></div>');
		$('#mobile-nav').find('.menu-has-children').prepend('<i class="fa fa-chevron-down"></i>');

		$(document).on('click', '.menu-has-children i', function (e) {
			$(this).next().toggleClass('menu-item-active');
			$(this).nextAll('ul').eq(0).slideToggle();
			$(this).toggleClass("fa-chevron-up fa-chevron-down");
		});

		$(document).on('click', '#mobile-nav-toggle', function (e) {
			$('body').toggleClass('mobile-nav-active');
			$('#mobile-nav-toggle i').toggleClass('fa-times fa-bars');
			$('#mobile-body-overly').toggle();
		});

		$(document).click(function (e) {
			var container = $("#mobile-nav, #mobile-nav-toggle");
			if (!container.is(e.target) && container.has(e.target).length === 0) {
				if ($('body').hasClass('mobile-nav-active')) {
					$('body').removeClass('mobile-nav-active');
					$('#mobile-nav-toggle i').toggleClass('fa-times fa-bars');
					$('#mobile-body-overly').fadeOut();
				}
			}
		});
	} else if ($("#mobile-nav, #mobile-nav-toggle").length) {
		$("#mobile-nav, #mobile-nav-toggle").hide();
	}

	// Smooth scroll for the menu and links with .scrollto classes
	$('.nav-menu a, #mobile-nav a, .scrollto').on('click', function () {
		if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
			var target = $(this.hash);
			if (target.length) {
				var top_space = 0;

				if ($('#header').length) {
					top_space = $('#header').outerHeight();

					if (!$('#header').hasClass('header-fixed')) {
						top_space = top_space - 20;
					}
				}

				$('html, body').animate({
					scrollTop: target.offset().top - top_space
				}, 1500, 'easeInOutExpo');

				if ($(this).parents('.nav-menu').length) {
					$('.nav-menu .menu-active').removeClass('menu-active');
					$(this).closest('li').addClass('menu-active');
				}

				if ($('body').hasClass('mobile-nav-active')) {
					$('body').removeClass('mobile-nav-active');
					$('#mobile-nav-toggle i').toggleClass('fa-times fa-bars');
					$('#mobile-body-overly').fadeOut();
				}
				return false;
			}
		}
	});

	$( "#myModal" ).on( "shown.bs.modal", function() {
		$( "#addEditForm" ).removeData( "validator" );
		jQuery( "#addEditForm" ).validate({
			errorClass: "is-invalid",
			errorPlacement: function (error, element) {
				// To avoid default messages from jquery-validate ( We're using bootstrap method to show errors )
				return true;
			},
			submitHandler: function( form ) {
				form.submit();
			}
		});
		// datepicker - all forms are mostly inside modal
		jQuery( ".datepicker" ).datepicker( { format: "yyyy-M-dd" } );
	});

	// There might be some forms with datepicker on main page itself
	jQuery( ".datepicker" ).datepicker( { format: "yyyy-M-dd" } );

	// hide alert after 10 seconds from page load complete
	setTimeout( function() {
		jQuery( "div.alert" ).slideUp( 1000 );
	}, 10000);
});
