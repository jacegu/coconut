require_relative 'blank_slate'
require_relative '../config'

module Coconut
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
        ::Kernel::raise InvalidName, "#{name} can't be used as property name" if _taken?(name)
        @properties[name] = args.first
      end
    end
  end
end
