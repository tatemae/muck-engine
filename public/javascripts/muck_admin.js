 jQuery(function(){
	// BUTTONS
	jQuery('.fg-button').hover(
		function(){ jQuery(this).removeClass('ui-state-default').addClass('ui-state-focus'); },
		function(){ jQuery(this).removeClass('ui-state-focus').addClass('ui-state-default'); }
	);
	jQuery('.flat').each(function() {
		jQuery(this).menu({ 
			content: jQuery(this).next().html(), // grab content from this page
			showSpeed: 200 
		});
	});
});