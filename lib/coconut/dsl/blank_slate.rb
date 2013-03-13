require_relative '../config'

module Coconut
  module Dsl
    class InvalidName < RuntimeError; end

    class BlankSlate < BasicObject
      def self.__forbidden_names
        Config.instance_methods + PERMANENT_PUBLIC_METHODS
      end

      private

      def _taken?(name)
        Config.instance_methods.include? name
      end

      def self.const_missing(name)
        super unless self.class.const_defined?(name)
        self.class.const_get(name)
      end

      def self.inherited(subclass)
        _eraseable_methods.each{ |method_name| undef_method method_name }
      end

      def self._eraseable_methods
        instance_methods - PERMANENT_PUBLIC_METHODS
      end

      PERMANENT_PUBLIC_METHODS = [:instance_eval, :__send__, :object_id, :__id__, :__forbidden_names]
    end
  end
end
