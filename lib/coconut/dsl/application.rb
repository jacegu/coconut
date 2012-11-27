require_relative 'asset'

module Coconut
  module Dsl
    class Application
      def initialize(current_environment)
        @current_environment = current_environment
      end

      def run(&config)
        @assets_config = {}
        instance_eval &config
        Config.new(@assets_config)
      end

      private

      def method_missing(asset, *args, &config)
        @assets_config[asset] = Asset.configure(@current_environment, &config)
      end
    end
  end
end
