//jQuery.noConflict();
jQuery(document).ajaxSend(function(event, request, settings) {
  add_headers(request);
  if (settings.type.toUpperCase() == 'GET' || typeof(AUTH_TOKEN) == "undefined") return; // for details see: http://www.justinball.com/2009/07/08/jquery-ajax-get-in-firefox-post-in-internet-explorer/
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
 	if (typeof(AUTH_TOKEN) != "undefined")
  	settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

function apply_ajax_forms() {
  jQuery('form.ajax').ajaxForm({
    dataType: 'script',
    beforeSend: add_headers
  });
	jQuery('form.ajax').append('<input type="hidden" name="format" value="js" />');
}

function add_headers(xhr){
	xhr.setRequestHeader("Accept", "text/javascript");
	xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
}

jQuery(document).ready(function() {

  jQuery('a.ajax-delete').live('click', function() {
    var title = jQuery(this).attr('title');
    var do_delete = true;
    if(title.length > 0){
      do_delete = confirm(title);
    }
    if (do_delete){
      jQuery.post(this.href, { _method: 'delete', format: 'js' }, null, "script");
    }
    return false;
  });

  jQuery('a.ajax-update').live('click', function() {
    jQuery.post(this.href, { _method: 'put', format: 'js' }, null, "script");
    return false;
  });

  jQuery(".submit-form").click(function() {
    jQuery(this).parent('form').submit();
  });

  apply_ajax_forms();

  jQuery('a.dialog-pop').live('click', function() {
    var d = jQuery('<div class="dialog"></div>').appendTo("body");
    d.dialog({ modal: true, autoOpen: false, width: 'auto', title: jQuery(this).attr('title') });
    d.load(jQuery(this).attr('href'), '', function(){
      d.dialog("open");
      apply_ajax_forms();
    });
    return false;
  });

  jQuery(".submit-delete").live('click', function() {
    jQuery(this).parents('.delete-container').fadeOut();
    var form = jQuery(this).parents('form');
    jQuery.post(form.attr('action') + '.json', form.serialize(),
      function(data){
        var json = eval('(' + data + ')');
        if(!json.success){
          jQuery.jGrowl.info(json.message);
        }
      });
    return false;
  });
  
  jQuery(".submit-delete-js").live('click', function() {
    jQuery(this).parents('.delete-container').fadeOut();
    var form = jQuery(this).parents('form');
    jQuery.post(form.attr('action') + '.js', form.serialize(),
      function(data){
      });
    return false;
  });

  jQuery(document).ready(function() {
    jQuery('.waiting').hide();
    jQuery(".wait-button").click(function() {
      jQuery('.waiting').show();
      jQuery(this).hide();
    });
  });

});