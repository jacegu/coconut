require_relative 'asset_file_list'

module Coconut
  module Dsl
    class AssetFolder
      def initialize(path, ignored_files)
        @path = path
        @ignored_files = ignored_files.map(&method(:path_to))
      end

      def each(&block)
        AssetFileList.new(*asset_files_in_folder).each(&block)
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
  end
end
