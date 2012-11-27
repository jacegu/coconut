require_relative 'asset'

module Coconut
  module Dsl
    class Application < BlankSlate
      def self.configure(current_environment, &config)
        new(current_environment).run(&config)
      end

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
        ::Kernel::raise InvalidName, __taken_error_message(asset, 'asset name') if __taken?(asset)
        @assets_config[asset] = Asset.configure(@current_environment, &config)
      end

    end
  end
end
