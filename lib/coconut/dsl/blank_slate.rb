module Coconut
  module Dsl
    class BlankSlate < BasicObject
      private

      def self.inherited(subclass)
        eraseable_methods.each{ |method_name| undef_method method_name }
      end

      def self.eraseable_methods
        instance_methods - PERMANENT_METHODS
      end

      PERMANENT_METHODS = [:instance_eval, :__send__, :object_id]
    end
  end
end
