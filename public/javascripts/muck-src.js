// compress with http://closure-compiler.appspot.com/home
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
	
	//jQuery("ul.drop-menu").menu();
	
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
    jQuery(".wait-button").live('click', function() {
      jQuery(this).siblings('.waiting').show();
      jQuery(this).hide();
    });
  });

});

// String list methods. These are handy for dealing with comma delimited lists
// in text boxes such as a list of emails or tags.
// Given a comma delimited string add a new item if it isn't in the string
function add_to_list(items_string, new_item){
  var items = split_list(items_string);
  var add = true;
  for(i=0;i<items.length;i++){
    if(items[i] == new_item){ add = false; }
  }
  if(add){ 
    items.push(new_item);
  }
  return items.join(', ');
}

// Given a comma delimited list remove an item from the string
function remove_from_list(items_string, remove_item){
  var items = split_list(items_string);
  var cleaned = [];
  for(i=0;i<items.length;i++){
    if(items[i] != remove_item){
      cleaned.push(items[i]);
    }
  }
  return cleaned.join(', ');
}

// Split a string on commas
function split_list(items_string){
  if(undefined != items_string && items_string.length > 0){
    var items = items_string.split(',');
  } else {
    var items = [];
  }
  var cleaned = [];
  for(i=0;i<items.length;i++){
    var cleaned_item = jQuery.trim(items[i]);
    if(cleaned_item.length > 0){ 
      cleaned.push(cleaned_item); 
    }
  }
  return cleaned;
}

function isEncodedHtml(str) { 
  if(str.search(/&amp;/g) != -1 || str.search(/&lt;/g) != -1 || str.search(/&gt;/g) != -1) 
    return true; 
  else 
    return false; 
}; 
 
function decodeHtml(str){ 
    if(isEncodedHtml(str)) 
      return str.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>'); 
    return str; 
}