require_relative 'blank_slate'

module Coconut
  module Dsl
    class AssetSetup < BlankSlate
      def initialize(properties)
        @properties = properties
      end

      def method_missing(name, *args, &block)
        return @properties[name] if @properties.has_key? name
        super
      end
    end
  end
end
