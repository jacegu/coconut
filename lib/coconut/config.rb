module Coconut
  class Config
    def self.with(properties)
      dup.tap do |new_config|
        new_config.instance_variable_set('@properties', properties)
        new_config.instance_variable_set('@config', config_from(properties))
      end
    end

    # Coconut::Config objects will respond to methods if its name is
    # equal to any of the configured properties. This method is redefined to
    # make its behaviour consistent with Coconut::Config#method_missing
    #
    # @return [Boolean] whether a config object knows how to respond to method "name"
    def self.respond_to?(name)
      property?(name) or super
    end

    # @return [Hash] a Hash representation of the configuration object
    def self.to_hash
      @properties.dup
    end

    def self.config_from(properties)
      properties.each_with_object({}) do |(property, value), config|
        config[property]= config_value_for(value)
      end
    end

    def self.config_value_for(value)
      return Config.with(value) if value.is_a? Hash
      value
    end

    def self.method_missing(name, *args, &block)
      if property?(name)
        define_property_accessor(name)
        return @config[name]
      end
      super
    end

    def self.const_missing(name)
      if property?(name.downcase)
        define_constant(name)
        return @config[name.downcase]
      end
      super
    end

    def self.property?(name)
      return false if @config.nil?
      @config.has_key?(name)
    end

    def self.define_property_accessor(name)
      singleton_class.instance_eval do
        define_method(name) { @config[name] }
      end
    end

    def self.define_constant(name)
      self.const_set(name, @config[name.downcase])
    end

    private_class_method :config_from,
                         :config_value_for,
                         :define_constant,
                         :define_property_accessor,
                         :method_missing,
                         :property?
  end
end
