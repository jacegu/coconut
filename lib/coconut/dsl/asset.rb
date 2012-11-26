require_relative '../config'
require_relative './environment'

module Coconut
  module Dsl
    class Asset
      def initialize(current_environment)
        @current_environment = current_environment
      end

      def run(&config)
        instance_eval &config
        @config
      end

      private

      def environment(environment, &environment_config)
        @config = Dsl::Environment.run(&environment_config) if current? environment
      end

      def current?(environment)
        @current_environment.to_sym == environment.to_sym
      end
    end
  end
end
