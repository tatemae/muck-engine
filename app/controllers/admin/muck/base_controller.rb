class Admin::Muck::BaseController < ApplicationController

  layout 'admin'
  
  before_filter :login_required
  before_filter :admin_access_required
  
  protected

    def get_user
      @user = current_user
    end
  
    def authorized?
      admin?
    end
  
    # called by Admin::Muck::BaseController to check whether or not the
    # user should have access to the admin UI
    def admin_access_required
      access_denied unless admin?
    end
    
    def permission_denied
      respond_to do |format|
        format.html do
          redirect_to home_path
        end
      end
    end

    # Output a page update that will display messages in the flash
    def output_admin_messages(fields = nil, title = '', options = { :class => 'notify-box' }, flash_only = false)
      @fields = fields
      @title = title
      @options = options
      @flash_only = flash_only
      render :partial => 'admin/shared/output_admin_messages'
    end

end