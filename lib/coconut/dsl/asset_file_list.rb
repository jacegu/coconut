require_relative 'asset_file'

module Coconut
  module Dsl
    class AssetFileList
      def self.config_from(*file_paths)
        new(*file_paths).assets_config
      end

      def initialize(*file_paths)
        @files = file_paths.map { |file| AssetFile.new(file) }
      end

      def assets_config
        @files.map { |file| file.asset_config }.join("\n")
      end
    end
  end
end
