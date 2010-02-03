class MuckEngine
  module FlashErrors
    
    # Output only flash errors
    def output_flash(options = {})
      output_errors('', options, nil, true)
    end

    # Output flash and object errors
    def output_errors(title, options = {}, fields = nil, flash_only = false)
      fields = [fields] unless fields.is_a?(Array)
      flash_html = render(:partial => 'shared/flash_messages')
      flash.clear
      css_class = "class=\"#{options[:class] || 'error'}\"" unless options[:class].nil?
      field_errors = render(:partial => 'shared/field_error', :collection => fields)

      if flash_only || (!flash_html.empty? && field_errors.empty?)
        # Only flash.  Don't render errors for any fields
        render(:partial => 'shared/flash_error_box', :locals => {:flash_html => flash_html, :css_class => css_class})
      elsif !field_errors.empty?
        # Field errors and/or flash
        render(:partial => 'shared/error_box', :locals => {:title => title,
          :flash_html => flash_html,
          :field_errors => field_errors,
          :css_class => css_class,
          :extra_html => options[:extra_html]})
      else
        #nothing
        ''
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
end