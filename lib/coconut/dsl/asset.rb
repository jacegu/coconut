require_relative '../config'
require_relative './environment'

module Coconut
  module Dsl
    class Asset
      def initialize(current_environment)
        @current_environment = current_environment
        @properties = {}
      end

      def run(&config)
        instance_eval &config
        @properties
      end

      private

      def environment(*environments, &config)
        environments.each { |environment| __configure(environment, config) }
      end

      alias :env          :environment
      alias :envs         :environment
      alias :environments :environment

      def __configure(environment, config)
        @properties.merge! Environment.configure(&config) if __current?(environment)
      end

      def __current?(environment)
        @current_environment.to_sym == environment.to_sym
      end
    end
  end
end
