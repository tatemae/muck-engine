function setup_country(force_load){

	var country_id = jQuery("#countries").val();
	var state_id = jQuery("#states").val();

	if (country_id == undefined){ 
		return; 
	}

	if (country_id == '-1'){
		jQuery("#states").val('-1');
		jQuery("#counties").val('-1');
	}

	if (country_id == '-1' || country_id == ''){
		jQuery("#states-container").hide();
		jQuery("#counties-container").hide();
		return;
	}

	if(force_load || state_id == '' || state_id == null || state_id == -1) {
		jQuery.getJSON("/load_states_for_country/" + country_id + ".json", function(data){
			var options = '';
			jQuery("#counties-container").hide();
			jQuery('#states-container label').html(data.label);
			states = data.states;
			if(states.length > 0){
				for (var i = 0; i < states.length; i++) {
					var state_id = states[i].state.id;
					if(state_id == undefined) { state_id = ''; }
					options += '<option value="' + state_id + '">' + states[i].state.name + '</option>';
				}
				jQuery("#states-container").show();
				jQuery("select#states").html(options);
			} else {
				jQuery("#states-container").hide();
			}
		});
	}
}

jQuery(document).ready(function() {
  jQuery("#countries-container select").change(function() {
		setup_country(true);
  });
	if(jQuery("#states").val() == '' || jQuery("#states").val() == null) {
		jQuery("#states-container").hide();
	}
	setup_country(false);
});