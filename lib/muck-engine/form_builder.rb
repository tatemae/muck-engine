require 'validation_reflection'

module MuckEngine
  class FormBuilder < ActionView::Helpers::FormBuilder

    helpers = field_helpers +
      %w(date_select datetime_select time_select collection_select) +
      %w(select country_select time_zone_select) -
      %w(hidden_field label fields_for)

    helpers.each do |name|
      define_method name do |field, *args|
        options = args.detect {|argument| argument.is_a?(Hash)} || {}

        render_field_template(name, field, options) do
          super(field, *args)
        end
      end
    end

    # Options to pass to render_field_template through the 'options' argument.
    # pre_html               html content to insert at the beginning of the container
    # extra_html             html content to insert at the end of the container
    # tip                    Text for a popup text tip.
    # tip_title              Title for popup text tip
    # tip_key                The id of the div that contains the tip text.
    # tip_position           Position for tip text.  Valid values are 'top', 'right', 'bottom', 'left'.  Default is 'right'
    # wrapper_id             Alternate id for the container.  Each field is typically wrapper in a div.  This is the id of that div.
    # wrapper_class          Css class for the container. All containers have the class form-row. This value will be in addition to that class.
    # label_class            Css class for the label
    # hide_label             Prevents a label from being output
    # hide_required          Do not show 'required' label even though field is required
    # hide_control_error     Hide errors that show up next to the field
    # required_text_mark     By default '(required)' is used to show required fields. Override this by setting required_text_mark to something else - ie '*'
    #                        Alternatively override 'muck.engine.required_text_mark' in your app's en.yml or the appropriate localization file. You can also
    #                        specify a value in global_config.yml with required_text_mark: *
    def render_field_template(name, field, options)

      tippable = !options[:tip].nil?

      # used by country, state and other selects to specify a different id
      field_id = options[:field_id]

      local_options = {
        :pre_html         => options.delete(:pre_html),
        :after_label_html => options.delete(:after_label_html),
        :extra_html       => options.delete(:extra_html),
        :tip              => options.delete(:tip),
        :tip_title        => options.delete(:tip_title),
        :tip_key          => options.delete(:tip_key),
        :tip_position     => options.delete(:tip_position) || 'right',
        :wrapper_id       => options.delete(:wrapper_id),
        :wrapper_class    => options.delete(:wrapper_class),
        :hide_required    => options.delete(:hide_required),
        :hide_control_error => options.delete(:hide_control_error),
        :css_class        => options.delete(:css_class)
      }
      # TODO css_class does not appear to be used. Can just use the standard :class in html options to set the class

      is_checkbox = false
      is_checkbox = true if %w(check_box).include?(name)

      required_text_mark = options.delete(:required_text_mark)

      type = options.delete(:type)
      type ||= :tippable if tippable

      label_class = ''
      label_class << "checkbox-label" if is_checkbox
      label_class << " #{options.delete(:label_class)}" if !options[:label_class].nil?
      if label_class.blank?
        label_options = {}
      else
        label_options = { :class => label_class }
      end

      if local_options[:hide_required]
        required = false
        label_text = options[:label]
      else
        required = required_field?(field)
        label_text = (options[:label] || field.to_s.camelize)
        label_text = label_text + required_mark(field, required_text_mark) if required
      end
      label_name = options.delete(:label)

      options[:class] ||= ''
      options[:class] << add_space_to_css(options) + 'tip-field' if tippable
      options[:class] << add_space_to_css(options) + "required-value" if required

      if type == :choose_menu
        options[:label_class] = 'desc'
      end

      if options.delete(:hide_label)
        label_element = ''
      else
        label_element = label(field, label_text.html_safe, label_options)
      end

      locals = {
        :field_element  => yield,
        :field_name     => field_id || field_name(field),
        :label_name     => options.delete(:required_label) || label_name || '',
        :label_element  => label_element,
        :is_checkbox    => is_checkbox,
        :required       => required
      }.merge(local_options)

      if object.nil?
        locals[:value] = ''
        locals[:id] = ''
      else
        locals[:value] = object.send(field)
        locals[:id] = object.id
      end

      if has_errors_on?(field)
        locals.merge!(:error => error_message(field, options))
      end

      @template.capture do

        if type == :tippable
          @template.render :partial => 'forms/field_with_tips', :locals => locals
        elsif type == :choose_menu
          @template.render :partial => 'forms/menu_field', :locals => locals
        elsif type == :color_picker
          @template.render :partial => 'forms/color_picker_field', :locals => locals
        elsif type == :default
          @template.render :partial => 'forms/default', :locals => locals
        else
          @template.render :partial => 'forms/field', :locals => locals
        end
      end
    end

    # Call '<%= country_scripts %>' to render javascript that will change the state control based on the current country
    # creates a select control with us states.  Default id is 'us_states'.  If 'retain' is passed for the class value the value of this
    # control will be written into a cookie with the key 'us_states'.
    def us_state_select(method, options = {}, html_options = {}, additional_state = nil)
      @@country_id ||= Country.find_by_abbreviation('US')
      @states = (additional_state ? [additional_state] : []) + State.find(:all, :conditions => ["country_id = ?", @@country_id], :order => "name asc")
      self.menu_select(method, I18n.t('muck.engine.choose_state'), @states, options.merge(:prompt => I18n.t('muck.engine.select_state_prompt'), :wrapper_id => 'us-states-container'), html_options.merge(:id => 'us-states'))
    end

    # creates a select control with states.  Default id is 'states'.  If 'retain' is passed for the class value the value of this
    # control will be written into a cookie with the key 'states'.
    def state_select(method, options = {}, html_options = {}, additional_state = nil)
      country_id_field_name = options.delete(:country_id) || 'country_id'
      country_id = get_instance_object_value(country_id_field_name)
      @states = country_id.nil? ? [] : (additional_state ? [additional_state] : []) + State.find(:all, :conditions => ["country_id = ?", country_id], :order => "name asc")
      self.menu_select(method, I18n.t('muck.engine.choose_state'), @states, options.merge(:prompt => I18n.t('muck.engine.select_state_prompt'), :wrapper_id => 'states-container'), html_options.merge(:id => 'states'))
    end

    # creates a select control with countries.  Default id is 'countries'.  If 'retain' is passed for the class value the value of this
    # control will be written into a cookie with the key 'countries'.
    def country_select(method, options = {}, html_options = {}, additional_country = nil)
      @countries ||= (additional_country ? [additional_country] : []) + Country.find(:all, :order => 'sort, name asc')
      self.menu_select(method, I18n.t('muck.engine.choose_country'), @countries, options.merge(:prompt => I18n.t('muck.engine.select_country_prompt'), :wrapper_id => 'countries-container'), html_options.merge(:id => 'countries'))
    end

    # creates a select control with languages.  Default id is 'languages'.  If 'retain' is passed for the class value the value of this
    # control will be written into a cookie with the key 'languages'.
    def language_select(method, options = {}, html_options = {}, additional_language = nil)
      @languages ||= (additional_language ? [additional_language] : []) + Language.find(:all, :order => 'name asc')
      self.menu_select(method, I18n.t('muck.engine.choose_language'), @languages, options.merge(:prompt => I18n.t('muck.engine.select_language_prompt'), :wrapper_id => 'languages-container'), html_options.merge(:id => 'languages'))
    end

    def get_instance_object_value(field_name)
      obj = object || @template.instance_variable_get("@#{@object_name}")
      obj.send(field_name) rescue nil
    end

    def menu_select(method, label, collection, options = {}, html_options = {})
      muck_select(method, :id, :name, label, collection, options, html_options)
    end

    def muck_select(method, value_method, name_method, label, collection, options = {}, html_options = {})

      # this code will look for a cookie that matches the control and set the value to the cookie value
      # if html_options.has_key?(:class)
      #     if html_options[:class].include?('retain')
      #         id = html_options[:id]
      #         @object.send("#{method}=", @template.cookies[id]) if @template.cookies.has_key? id
      #     end
      # end
      if !options[:tip].nil?
        html_options[:class] ||= ''
        html_options[:class] << add_space_to_css(html_options) + 'tip-field'
      end
      self.collection_select(method, collection, value_method, name_method, options.merge(:object => @object, :label => label, :type => :choose_menu, :label_class => 'desc', :field_id => html_options[:id]), html_options)
    end

    private

    def add_space_to_css(options)
      options[:class].empty? ? '' : ' '
    end

    def error_message(field, options)
      if has_errors_on?(field)
        errors = object.errors[field]
        errors.is_a?(Array) ? errors.to_sentence : errors
      else
        ''
      end
    end

    def has_errors_on?(field)
      !(object.nil? || object.errors[field].blank?)
    end

    def field_name(field)
      # TODO figure out if there is a built in method that does this.
      "#{@object_name.to_s}_#{field.to_s}"
    end

    def required_mark(field, required_text_mark = nil)
      required_text_mark ||= MuckEngine.configuration.required_text_mark || I18n.translate('muck.engine.required_text_mark')
      required_field?(field) ? " <em id=\"#{field_name(field)}-label-required\">#{required_text_mark}</em>" : ''
    end

    def required_field?(field)
      reflect_on = object.class if !object.blank?
      if reflect_on.blank?
        reflect_on = @object_name.to_s.camelize.constantize rescue nil
      end
      if !reflect_on.blank?
        reflect_on.reflect_on_validations_for(field).map(&:macro).include?(:validates_presence_of)
      else
        false
      end
    end

    def load_states
      @states = State.find(:all, :order => "name" ).map {|u| [u.name, u.id] }
    end

  end
end