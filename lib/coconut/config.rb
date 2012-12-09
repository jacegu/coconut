module Coconut
  class Config
    def initialize(properties)
      @properties = properties
      @config = config_from(properties)
    end

    # Coconut::Config objects will respond to methods if its name is
    # equal to any of the configured properties. This method is redefined to
    # make its behaviour consistent with Coconut::Config#method_missing
    #
    # @return [Boolean] whether a config object knows how to respond to method "name"
    def respond_to?(name)
      property?(name) or super
    end

    # @return [Hash] a Hash representation of the configuration object
    def to_hash
      @properties.dup
    end

    private

    def config_from(properties)
      properties.each_with_object({}) do |(property, value), config|
        config[property]= config_value_for(value)
      end
    end

    def config_value_for(value)
      return Config.new(value) if value.is_a? Hash
      value
    end

    def method_missing(name, *args, &block)
      if property?(name)
        define_property_accessor(name)
        return @config[name]
      end
      super
    end

    def property?(name)
      @config.has_key?(name)
    end

    def define_property_accessor(name)
      singleton_class.instance_eval do
        define_method(name) { @config[name] }
      end
    end
  end
end
