jQuery(document).ready(function() {
	jQuery("#user_login").blur(function(){
	  jQuery.post("/users/is_login_available",{ user_login:jQuery(this).val(), format:'js' },function(data){
	    jQuery("#username-availibility").html(data);
	  });
	});
	jQuery("#user_login").keydown(function() {
	  jQuery("#username-availibility").html('');
	});
	jQuery("#user_email").blur(function(){
	  jQuery.post("/users/is_email_available",{ user_email:jQuery(this).val(), format:'js' },function(data){
	    jQuery("#email-availibility").html(data);
	  });
	});
	jQuery("#user_email").keydown(function() {
	  jQuery("#email-availibility").html('');
	});
	jQuery(".login-search").autocomplete('/users/login_search.js', {
		minChars: 1,
		delay: 200,
		autoFill: true,
		mustMatch: false
	});
});