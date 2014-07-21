module MuckEngine
  class JsonParser

    # The various json parsers can choke on various json so try them all
    def self.json_parse(data)
      try_crack(data) || try_json(data) || try_active_json(data)
    end

    def self.try_crack(data)
      Crack::JSON.parse(data)
    rescue => ex
      #puts ex
      nil
    end

    def self.try_json(data)
     JSON.parse(data)
    rescue => ex
      #puts ex
      nil
    end

    def self.try_active_json(data)
      ActiveSupport::JSON.decode(data)
    rescue => ex
      #puts ex
      nil
    end

  end
end