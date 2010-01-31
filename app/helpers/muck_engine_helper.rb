require 'md5'

module MuckEngineHelper

  # Outputs the appropriate http protocol based on 
  # the request type.  if https is desired then 
  # pass true to override default behavior
  def http_protocol(use_ssl = request.ssl?)
    (use_ssl ? "https://" : "http://")
  end

  # Outputs a small bit of javascript that will enable message 
  # output to jgrowl or to the given message dom id
  #
  # message_dom_id: The dom id of the element that will hold messages.
  #                 This element can have display:none by default.
  def jquery_message(message_dom_id)
    if GlobalConfig.growl_enabled
      "jQuery('##{message_dom_id}').html(json.message);"
      "jQuery('##{message_dom_id}').show();"
    else
      "jQuery.jGrowl.info(json.message);"
    end
  end
  
  # Outputs scripts that manipulate the country and state select controls
  def country_scripts
    return if @@country_scripts_included
    @@country_scripts_included = true
    render :partial => 'scripts/country_scripts'
  end
  
  def custom_form_for(record_or_name_or_array, *args, &proc) 
    options = args.detect { |argument| argument.is_a?(Hash) } 
    if options.nil? 
      options = {:builder => MuckCustomFormBuilder} 
      args << options 
    end 
    options[:builder] = MuckCustomFormBuilder unless options.nil? 
    form_for(record_or_name_or_array, *args, &proc) 
  end
  
  def custom_remote_form_for(record_or_name_or_array, *args, &proc) 
    options = args.detect { |argument| argument.is_a?(Hash) } 
    if options.nil? 
      options = {:builder => MuckCustomFormBuilder} 
      args << options 
    end 
    options[:builder] = MuckCustomFormBuilder unless options.nil? 
    remote_form_for(record_or_name_or_array, *args, &proc) 
  end
  
  # generates javascript that will hide a link or button
  # when click and then show a different dom object
  def show_hide_on_click(id_to_show, id_to_hide)
    %Q{jQuery(document).ready(function() {
      jQuery('##{id_to_hide}').click(function(){
        jQuery(this).hide();
        jQuery('##{id_to_show}').show();
      });
    });}
  end
  
  # Render a photo for the given object.  Note that the object will need a 'photo' method
  # provided by paperclip. If the object does not provide an image, but does have an 'email' method
  # this method will attempt to use gravatar.com to find a matching image.  
  # 
  # object:           Object to get icon for.
  # size:             Size to get. size is commonly one of:
  #                     :medium, :thumb, :icon or :tiny but can be any value provided by the photo object
  # default_image:    A default image should the photo not be found.
  # gravatar_size:    Size in pixels for the gravatar.  Can be from 1 to 512.  For reference the sizes from muck-profiles are:
  #                   medium: 300, thumb: 100, icon: 50, tiny: 24.  The default is set to 50 to match the default 'size' setting which is icon.
  # rating:           Default gravatar rating - g, pg, r, x.
  # gravatar_default: If a gravatar is used, but no image is found several defaults are available.  Leaving 
  #                   this value nil will result in the 'default_image' being used.  Other wise one of the following can be set:
  #                   identicon, monsterid, wavatar, 404
  def icon(object, size = :icon, default_image = '/images/profile_default.jpg', use_only_gravatar = false, gravatar_size = 50, rating = 'g', gravatar_default = nil)
    return "" if object.blank?
    
    if object.photo.original_filename && !use_only_gravatar
      image_url = object.photo.url(size) rescue nil
    end
    
    if image_url.blank? && defined?(object.email)
      gravatar_default = File.join(root_url, default_image) if gravatar_default.blank?
      image_url = gravatar(object.email, gravatar_default, gravatar_size, rating)
    else
      image_url ||= default_image
    end
    
    link_to(image_tag(image_url, :class => size), object, { :title => object.full_name })
  end
  
  # Gets a gravatar for a given email
  #
  # gravatar_default: If a gravatar is used, but no image is found several defaults are available.  Leaving 
  #                   this value nil will result in the 'default_image' being used.  Other wise one of the following can be set:
  #                   identicon, monsterid, wavatar, 404
  # size:             Size in pixels for the gravatar.  Can be from 1 to 512.
  # rating:           Default gravatar rating - g, pg, r, x.
  def gravatar(email, gravatar_default, size = 40, rating = 'g')
    hash = MD5::md5(email)
    image_url = "http://www.gravatar.com/avatar/#{hash}"
    image_url << "?d=#{CGI::escape(gravatar_default)}"
    image_url << "&s=#{size}"
    image_url << "&r=#{rating}"
  end
  
  # Generates a css style for the given service
  def service_icon_background(service)
    if service.respond_to?(:icon)
      service_name = service.icon
    else
      service_name = "#{service}.png"
    end
    %Q{style="background: transparent url('#{service_image(service_name, 24)}') no-repeat scroll left top;"}
  end
  
  # Builds a link to an image representing the service specified by name
  # name: Name of a service.  ie twitter, google, delicious, etc
  # size: Size of the image to get. Valid values are 16, 24, 48 and 60
  def service_image(name, size = 24)
    %Q{/images/service_icons/#{size}/#{name}}
  end
  
  # Renders an icon for the given service
  # Name is the name of the image file associated with the service
  # Size can be one of 16, 24, 48 or 60.
  def service_icon(name, size = 24)
    %Q{<img src="/images/service_icons/#{size}/#{name}" />}
  end
  
  # Generates a secure mailto link
  def secure_mail_to(email)
    mail_to email, nil, :encode => 'javascript'
  end
  
  # Used inside of format.js to return a message to the client.
  # If jGrowl is enabled the message will show up as a growl instead of a popup
  def page_alert(message, title = '')
    if GlobalConfig.growl_enabled
      "jQuery.jGrowl.error('" + message + "', {header:'" + title + "'});"
    else
      "alert(#{message});"
    end
  end
  
  # Override link_to_remote so that instead of '#' the proper url is rendered
  # This makes the link usable even if javascript is disabled
  # See: http://www.intridea.com/2007/11/21/link_to_remote-unobtrusively
  def link_to_remote(name, options = {}, html_options = {})  
    html_options.merge!({:href => url_for(options[:url])}) unless options[:url].blank?
    super(name, options, html_options)  
  end
  
  def locale_link(name, locale)
    parts = request.host.split('.')
    first_subdomain = parts.first
    request_uri = request.request_uri
    if first_subdomain == 'www' or Language.supported_locale?(first_subdomain)
      link_to name, request.protocol + (locale == I18n.default_locale.to_s ? 'www' : locale) + '.' + parts[1..-1].join('.') + request.port_string + request_uri
    elsif /^localhost/.match( request.host ) or /^(\d{1,3}\.){3}\d{1,3}$/.match( request.host )
      if request_uri.include?('?')
        if request_uri.include?('locale')
          link_to name, request.protocol + request.host_with_port + request_uri.sub(/locale=.*/, 'locale=' + locale)
        else
          link_to name, request.protocol + request.host_with_port + request_uri + '&locale=' + locale
        end
      else
        link_to name, request.protocol + request.host_with_port + request_uri + '?locale=' + locale
      end  
    else
      link_to name, request.protocol + (locale == I18n.default_locale.to_s ? 'www' : locale) + '.' + request.host_with_port + request_uri
    end
  end

  # Generate parameters for a url that refer to a given object as parent.  Useful
  # for comments, shares, etc
  def make_muck_parent_params(parent)
    return if parent.blank?
    { :parent_id => parent.id, :parent_type => parent.class.to_s }
  end
  
  # Generate hidden input fields that refer to a given object as parent.
  def make_muck_parent_fields(parent)
    return if parent.blank?
    %Q{<input id="parent_id" type="hidden" value="#{parent.id}">
    <input id="parent_type" type="hidden" value="#{parent.class.to_s}">}
  end
  
  # Take a block and renders that block within the context of a partial.
  # from http://snippets.dzone.com/posts/show/2483
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :locals => options))
  end
    
  # Take a block and renders that block within the context of a partial.
  # Passes the block to the partial.  The partial is then responsible for
  # capturing and rendering the block.
  # from http://snippets.dzone.com/posts/show/2483
  def raw_block_to_partial(partial_name, options = {}, &block)
    options.merge!(:block => block)
    concat(render(:partial => partial_name, :locals => options))
  end
  
  # Summarize html content by removing html
  # tags and truncating at a given number of words.
  # Truncation will occur at word boundries
  # Parameters:
  #   text    - The text to truncate
  #   length  - The desired number of words
  #   omission  - Text to add when the text is truncated ie 'read more'
  def html_summarize(text, length = 30, omission = '...')
    snippet(strip_tags(text), length, omission)
  end
  
  # Truncates text at a word boundry and provides a 
  # parameter for a 'more link'
  # Parameters:
  #   text      - The text to truncate
  #   wordcount - The number of words
  #   omission  - Text to add when the text is truncated ie 'read more'
  def snippet(text, wordcount, omission)
   text.split[0..(wordcount-1)].join(" ") + (text.split.size > wordcount ? " " + omission : "")
  end

  def round(flt)
    return (((flt.to_f*100).to_i.round).to_f)/100.0
  end

  def truncate_on_word(text, length = 270, end_string = ' ...')
    if text.length > length
      stop_index = text.rindex(' ', length)
      stop_index = length - 10 if stop_index < length-10
      text[0,stop_index] + (text.length > 260 ? end_string : '')
    else
      text
    end
  end
  
  def truncate_words(text, length = 40, end_string = ' ...')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
  
  # Outputs a javascript include localized for specific time actions
  def time_scripts(locale)
    render :partial => 'scripts/time_scripts', :locals => {:locale => locale}
  end

  # Outputs a snippet of javascript that can parse uris
  # http://blog.stevenlevithan.com/archives/parseuri
  def parse_uri_script
    render :partial => 'scripts/parse_uri'
  end
  
  def safe_id(term)
    term = URI.escape(term)
    term = term.gsub('.', '%2E')
  end
  
  def format_date(date)
    return '' if date.nil?
    date.to_date.to_s(:long)
  end
  
end
