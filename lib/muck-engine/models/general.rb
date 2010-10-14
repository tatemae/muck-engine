module MuckEngine
  module General
    
    extend ActiveSupport::Concern
    
    def dom_id(prefix='')
      display_id = new_record? ? "new" : id.to_s 
      prefix.to_s <<( '_') unless prefix.blank?
      prefix.to_s << "#{self.class.name.underscore}"
      prefix != :bare ? "#{prefix.to_s.underscore}_#{display_id}" : display_id
    end

    def errors_to_s
      errors.map do |e, m|
        "#{e.humanize unless e == "base"} #{m}\n"
      end.to_s.chomp
    end

  end
end