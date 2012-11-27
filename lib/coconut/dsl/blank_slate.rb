module Coconut
  module Dsl
    class InvalidName < Exception; end

    class BlankSlate < BasicObject
      private

      def self.inherited(subclass)
        __eraseable_methods.each{ |method_name| undef_method method_name }
      end

      def __taken?(name)
        Config.instance_methods.include? name
      end

      def __taken_error_message(name, usage)
        "#{name} can't be used as asset name: it will collide with Coconut::Config methods"
      end

      def self.__eraseable_methods
        instance_methods - PERMANENT_METHODS
      end

      PERMANENT_METHODS = [:instance_eval, :__send__, :object_id, :__taken?, :__taken_error_message]
    end
  end
end
