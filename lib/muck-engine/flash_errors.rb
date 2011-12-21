module MuckEngine
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

    # Output a message container that is hidden by default.  This can be used to create html where an
    # ajax call can drop messages.  Just do something like jQuery('#message_id).html('some message');
    def output_message_container(message_id = 'message_id', message_container_id = 'errorExplanation', css_class = 'notify-box')
      render :partial => 'shared/message_container', :locals => { :message_id => message_id,
                                                                  :message_container_id => message_container_id,
                                                                  :css_class => css_class }
    end

    # Output a page update that will display messages in the flash
    def output_admin_messages(fields = nil, title = '', options = { :class => 'notify-box' }, flash_only = false)
      output_errors_ajax('admin-messages', title, options, fields, flash_only)
    end

    # Output a message that can be show for an ajax request.
    # Parameters:
    # dom_id:     The id of the dom element that will contain the message content. If growl is enabled this value is irrelevant.
    # title:      Title to display for the error.
    # options:    Options. Currently the css class can be specified via this parameter.
    # fields:     The instance object for which to display errors. ie @user, @project, etc.
    # flash_only: If true show only flash messages.
    # decode_html: Occasionally the html sent to the client is encoded and the result is visible html. Set this value to true if this happens.
    # growl:      Can be used to make this a growl message even if growl_enabled is false. Note that if growl_enabled is enabled setting this
    #             value will have no effect.
    def output_errors_ajax(dom_id, title = '', options = { :class => 'notify-box' }, fields = nil, flash_only = false, decode_html = false, growl = MuckEngine.configuration.growl_enabled)
      render :partial => 'shared/output_ajax_messages', :locals => {:fields => fields,
                                                                    :title => title,
                                                                    :options => options,
                                                                    :flash_only => flash_only,
                                                                    :dom_id => dom_id,
                                                                    :growl => growl,
                                                                    :decode_html => decode_html }
    end

  end
end