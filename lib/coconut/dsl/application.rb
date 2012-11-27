require_relative 'asset'

module Coconut
  module Dsl
    class Application
      def initialize(current_environment)
        @current_environment = current_environment
        @config = {}
      end

      def run(&config)
        instance_eval &config
        Config.new(@config)
      end

      private

      def method_missing(name, *args, &block)
        @config[name] = Asset.new(@current_environment).run(&block)
      end
    end
  end
end
