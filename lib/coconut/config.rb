module Coconut
  class Config
    def initialize(properties)
      @properties = properties
    end

    def respond_to?(name)
      property?(name) or super
    end

    def to_hash
      Hash.new[@properties]
    end

    private

    def method_missing(name, *args, &block)
      if property?(name)
        define_property_accessor(name)
        return @properties[name]
      end
      super
    end

    def property?(name)
      @properties.has_key?(name)
    end

    def define_property_accessor(name)
      singleton_class.instance_eval do
        define_method(name) { @properties[name] }
      end
    end
  end
end
