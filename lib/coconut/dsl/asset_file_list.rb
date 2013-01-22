module Coconut
  module Dsl
    class AssetFileList
      def initialize(*file_paths)
        @paths = file_paths
      end

      def each(&block)
        @paths.each { |path| yield File.read(path), path }
      end
    end
  end
end
