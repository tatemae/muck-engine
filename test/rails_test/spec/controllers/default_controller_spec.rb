require File.dirname(__FILE__) + '/../spec_helper'

describe DefaultController do

  render_views
  
  it "should detect the iphone" do
    controller.should be_an_instance_of(DefaultController)
  end

end



   # # Detect the iphone.  Just call this method in a before filter:
   #  #    before_filter :adjust_format_for_iphone
   #  def adjust_format_for_iphone
   #    request.format = :iphone if iphone_user_agent?
   #  end
   #  
   #  # Request from an iPhone or iPod touch? (Mobile Safari user agent)
   #  def iphone_user_agent?
   #    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
   #  end
   #  
   #  # Output a simple javascript message
   #  def page_alert(message)
   #    render :template => 'shared/page_alert'
   #  end
   #  
   #  # **********************************************
   #  # Locale methods
   #  # I18n methods from:
   #  # http://guides.rubyonrails.org/i18n.html
   #  # http://zargony.com/2009/01/09/selecting-the-locale-for-a-request
   #  def discover_locale
   #    I18n.locale = extract_locale_from_user_selection || extract_locale_from_tld || extract_locale_from_subdomain || extract_locale_from_headers || I18n.default_locale
   #  end
   #  
   #  def extract_locale_from_browser
   #    if http_lang = request.env["HTTP_ACCEPT_LANGUAGE"] and ! http_lang.blank?
   #      browser_locale = http_lang[/^[a-z]{2}/i].downcase + '-' + http_lang[3,2].upcase
   #      browser_locale.sub!(/-US/, '')
   #    end
   #    nil
   #  end
   # 
   #  def extract_locale_from_user_selection
   #    extract_locale_from_url || extract_locale_from_cookie
   #  end
   #  
   #  def extract_locale_from_url
   #    if !params[:locale].blank? && I18n.available_locales.include?(params[:locale].to_sym)
   #      cookies['locale'] = { :value => params[:locale], :expires => 1.year.from_now }
   #      params[:locale].to_sym
   #    end
   #  end
   #  
   #  def extract_locale_from_cookie
   #    if cookies['locale'] && I18n.available_locales.include?(cookies['locale'].to_sym)
   #      cookies['locale'].to_sym
   #    end
   #  end
   #  
   #  def extract_locale_from_headers
   #    if http_lang = request.headers["HTTP_ACCEPT_LANGUAGE"] and ! http_lang.blank?
   #      preferred_locales = http_lang.split(',').map { |l| l.split(';').first }
   #      accepted_locales = preferred_locales.select { |l| I18n.available_locales.include?(l.to_sym) }
   #      accepted_locales.empty? ? nil : accepted_locales.first.to_sym
   #    end
   #  end
   #  
   #  # Get locale from top-level domain or return nil if such locale is not available 
   #  # You have to put something like: # 127.0.0.1 application.com 
   #  # 127.0.0.1 application.it # 127.0.0.1 application.pl 
   #  # in your /etc/hosts file to try this out locally 
   #  def extract_locale_from_tld 
   #    parsed_locale = request.host.split('.').last 
   #    (I18n.available_locales.include? parsed_locale) ? parsed_locale.to_sym : nil 
   #  end 
   # 
   #  # Get locale code from request subdomain (like http://it.application.local:3000) 
   #  # You have to put something like: 
   #  # 127.0.0.1 gr.application.local 
   #  # in your /etc/hosts file to try this out locally 
   #  def extract_locale_from_subdomain 
   #    parsed_locale = request.subdomains.first
   #    if !parsed_locale.blank?
   #      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale.to_sym : nil 
   #    else
   #      nil
   #    end
   #  end
   #        
   #  # **********************************************
   #  # Paging methods
   #  def setup_paging
   #    @page = (params[:page] || 1).to_i
   #    @page = 1 if @page < 1
   #    @per_page = (params[:per_page] || (RAILS_ENV=='test' ? 1 : 40)).to_i
   #  end
   # 
   #  def set_will_paginate_string
   #    # Because I18n.locale are dynamically determined in ApplicationController, 
   #    # it should not put in config/initializers/will_paginate.rb
   #    WillPaginate::ViewHelpers.pagination_options[:previous_label] = t('muck.general.previous')
   #    WillPaginate::ViewHelpers.pagination_options[:next_label] = t('muck.general.next')
   #  end
   # 
   #  # **********************************************
   #  # Email methods
   #  
   #  # Use send_form_email to send the contents of any form to the support email address
   #  def send_form_email(params, subject)
   #    body = []
   #    params.each_pair { |k,v| body << "#{k}: #{v}"  }
   #    BasicMailer.mail(:subject => subject, :body => body.join("\n")).deliver
   #  end
   #  
   #  # render methods
   #  def render_as_html
   #    last_template_format = @template.template_format
   #    @template.template_format = :html
   #    result = yield
   #    @template.template_format = last_template_format
   #    result
   #  end
   #  
   #  # **********************************************
   #  # Parent methods
   #  
   #  # Builds parameters that can be appended to a url to indicate the object's parent.
   #  # Note that this method should only be used when absolutely needed.  The preferred method is
   #  # to use polymorhpic_url.  For example:
   #  #     polymorphic_url([@parent, feeds])
   #  #     edit_polymorphic_url([@parent, @item])
   #  def make_parent_params(parent)
   #    if parent.blank?
   #      {}
   #    else
   #      { :parent_id => parent.id, :parent_type => parent.class.to_s }
   #    end
   #  end
   #  
   #  # Attempts to create an @parent object using params
   #  # or the url.
   #  # scope:  Friendly id can require a scope to find the object.  Pass the scope as needed.
   #  # ignore: Names to ignore.  For example if the url is /foo/1/bar?thing_id=1
   #  #         you might want to ignore thing_id so pass :thing.
   #  def setup_parent(args = {})
   #    @parent = get_parent(args)
   #    if @parent.blank?
   #      render :text => t('muck.engine.missing_parent_error')
   #      return false
   #    end
   #  end
   # 
   #  # Tries to get parent using parent_type and parent_id from the url.
   #  # If that fails and attempt is then made using find_parent
   #  # parameters:
   #  # scope:  Friendly id can require a scope to find the object.  Pass the scope as needed.
   #  # ignore: Names to ignore.  For example if the url is /foo/1/bar?thing_id=1
   #  #         you might want to ignore thing_id so pass :thing.
   #  def get_parent(args = {})
   #    if params[:parent_type].blank? || params[:parent_id].blank?
   #      find_parent(args)
   #    else
   #      klass = params[:parent_type].to_s.constantize
   #      if args.has_key?(:scope)
   #        klass.find(params[:parent_id], :scope => args[:scope])
   #      else
   #        klass.find(params[:parent_id])
   #      end
   #    end
   #  end
   # 
   #  # Searches the params to try and find an entry ending with _id
   #  # ie article_id, user_id, etc.  Will return the first value found.
   #  # parameters:
   #  # scope:  Friendly id can require a scope to find the object.  Pass the scope as needed.
   #  # ignore: Names to ignore.  For example if the url is /foo/1/bar?thing_id=1
   #  #         you might want to ignore thing_id so pass 'thing' to be ignored.
   #  def find_parent(args = {})
   #    ignore = args.delete(:ignore) || []
   #    ignore.flatten!
   #    params.each do |name, value|
   #      if name =~ /(.+)_id$/
   #        if !ignore.include?($1)
   #          if args.has_key?(:scope)
   #            return $1.classify.constantize.find(value, :scope => args[:scope])
   #          else
   #            return $1.classify.constantize.find(value)
   #          end
   #        end
   #      end
   #    end
   #    nil
   #  end
