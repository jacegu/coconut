require_relative './environment'
require_relative './asset_setup'

module Coconut
  module Dsl
    class Asset
      def self.configure(environment, &config)
        new(environment).run(&config)
      end

      def initialize(current_environment)
        @current_environment = current_environment
      end

      def run(&config)
        @properties = {}
        instance_eval &config
        @properties
      end

      private

      def setup(&code)
        AssetSetup.new(@properties).instance_eval(&code)
      end

      def environment(*environments, &config)
        environments.each { |environment| _configure(environment, config) }
      end

      alias :env          :environment
      alias :envs         :environment
      alias :environments :environment

      def _configure(environment, config)
        @properties.merge! Environment.configure(&config) if _current?(environment)
      end

      def _current?(environment)
        @current_environment.to_sym == environment.to_sym
      end
    end
  end
end
