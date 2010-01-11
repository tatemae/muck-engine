class Admin::Muck::DefaultController < Admin::Muck::BaseController
  
  def index
    respond_to do |format|
      format.html { render :template => 'admin/default/index' }
    end
  end
  
end