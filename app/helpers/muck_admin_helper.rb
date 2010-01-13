module MuckAdminHelper

  def sub_navigation
    render :partial => @sub_navigation_path if @sub_navigation_path
  end

end