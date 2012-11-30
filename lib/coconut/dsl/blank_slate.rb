require_relative '../config'

module Coconut
  module Dsl
    class InvalidName < Exception; end

    class BlankSlate < BasicObject
      def self.__forbidden_names
        Config.instance_methods + PERMANENT_METHODS
      end

      private

      def __taken?(name)
        Config.instance_methods.include? name
      end

      def __taken_error_message(name, usage)
        "#{name} can't be used as #{usage}: it will collide with Coconut::Config methods"
      end

      def self.inherited(subclass)
        __eraseable_methods.each{ |method_name| undef_method method_name }
      end

      def self.__eraseable_methods
        instance_methods - PERMANENT_METHODS
      end

      PERMANENT_METHODS = [:instance_eval, :__send__, :object_id, :__taken?, :__taken_error_message]
    end
  end
end
