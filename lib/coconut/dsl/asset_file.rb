module Coconut
  module Dsl
    class AssetFile
      def initialize(path)
        @path = path
      end

      def asset_config
        ::File.read(@path)
      end
    end
  end
end
