require_relative 'blank_slate'
require_relative '../config'

module Coconut
  class InvalidName < Exception
  end

  module Dsl
    class Environment < BlankSlate
      def self.configure(&config)
        new.configure(&config)
      end

      def initialize
        @properties = {}
      end

      def configure(&config)
        instance_eval &config
        @properties
      end

      private

      def method_missing(name, *args, &block)
        ::Kernel::raise InvalidName, __taken_error_message(name) if __taken?(name)
        @properties[name] = args.first
      end

      def __taken?(name)
        Config.instance_methods.include? name
      end

      def __taken_error_message(name)
        "#{name} can't be used as configuration property: it will collide with Coconut::Config methods"
      end
    end
  end
end
