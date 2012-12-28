module Coconut
  module Dsl
    class AssetFile
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def asset_config
        ::File.read(@path)
      end
    end
  end
end
