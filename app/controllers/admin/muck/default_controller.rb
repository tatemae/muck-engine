class Admin::Muck::DefaultController < Admin::Muck::BaseController
  
  def index
    @page_title = translate('muck.engine.admin_home_title')
    respond_to do |format|
      format.html { render :template => 'admin/default/index' }
    end
  end
  
end