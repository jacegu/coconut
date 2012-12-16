module Coconut
  module Dsl
    class AssetFolder
      def self.config_from(path, ignored_files)
        new(path, ignored_files).assets_config
      end

      def initialize(path, ignored_files)
        @path = path
        @ignored_files = ignored_files.map(&method(:path_to))
      end

      def assets_config
        AssetFileList.new(asset_files_in_folder).assets_config
      end

      private

      def asset_files_in_folder
        ruby_files_in_folder - @ignored_files
      end

      def ruby_files_in_folder
        files_in_folder.select { |file| file.match /\.rb$/ }
      end

      def files_in_folder
        folder.entries.map(&method(:path_to)).reject { |path| File.directory? path }
      end

      def folder
        Dir.open(@path)
      end

      def path_to(file)
        File.expand_path(File.join(@path, file))
      end
    end

    class AssetFileList
      def initialize(paths)
        @files = paths.map { |file| asset_config_in(file) }
      end

      def assets_config
        @files.map { |file| file.asset_config }.join("\n")
      end

      private

      def asset_config_in(file)
        AssetFile.new(file)
      end
    end

    class AssetFile
      def initialize(path)
        @path = path
      end

      def asset_config
        File.read(@path)
      end
    end
  end
end
