class Muck::HelperController < ApplicationController

  def load_states_for_country
    country_id = params[:id]
    @states = State.find(:all, :select => 'id, name', :conditions => ["country_id = ?", country_id], :order => "name" )
    label, prompt = Country.build_state_prompts(country_id, true)
    @states.insert(0, State.new(:name => prompt)) if @states.length > 0
    # set cookies so we can remember the last value the user selected
    cookies[:prefered_country_id] = country_id
    respond_to do |format|
      format.json { render :json => {:states => @states, :label => label, :prompt => prompt}.as_json }
    end
  end

end