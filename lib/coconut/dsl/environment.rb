require_relative '../config'

module Coconut
  module Dsl
    class Environment
      def self.run(&config)
        new.run(&config)
      end

      def initialize
        @properties = {}
      end

      def run(&config)
        instance_eval &config
        Config.new(@properties)
      end

      private

      def method_missing(name, *args, &block)
        @properties[name] = args.first
      end
    end
  end
end
