module Coconut
  module Dsl
    class AssetFolder
      def self.config_from(path, ignored_files)
        new(path, ignored_files).assets_config
      end

      def initialize(path, ignored_files)
        @path = path
        @ignored_files = ignored_files
      end

      def assets_config
        asset_files_in_folder.map { |file| content(file) }.join "\n"
      end

      private

      def asset_files_in_folder
        files_in_folder - @ignored_files
      end

      def files_in_folder
        folder.entries.map(&method(:path_to)).reject { |path| File.directory? path }
      end

      def folder
        Dir.open(@path)
      end

      def content(file)
        File.read(file)
      end

      def path_to(file)
        File.expand_path(File.join(@path, file))
      end
    end
  end
end
