require_relative 'asset'
require_relative 'asset_folder'

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

      def asset_folder(path)
        AssetFolder.new(path, IGNORED_FILES).each do |asset_config, path|
          instance_eval(asset_config, path)
        end
      end

      def asset_files(*files)
        AssetFileList.new(*files).each do |asset_config, path|
          instance_eval(asset_config, path)
        end
      end

      def method_missing(asset, *args, &config)
        ::Kernel::raise InvalidName, __taken_error_message(asset, 'asset name') if __taken?(asset)
        @assets_config[asset] = Asset.configure(@current_environment, &config)
      end

      IGNORED_FILES = ['config.rb']
    end
  end
end
