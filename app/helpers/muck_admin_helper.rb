module MuckAdminHelper

  def sub_navigation
    render :partial => @sub_navigation_path if @sub_navigation_path
  end

  def header_nav_item_image(header_nav_item)
    if !header_nav_item.image.blank?
      style="background-image:url('#{header_nav_item.image}');"
    end
  end

  # Generates a string that will hide admin messages.
  def hide_admin_messages
    "jQuery('#admin-messages').hide();"
  end

end