require_relative '../config'

module Coconut
  module Dsl
    class InvalidName < RuntimeError; end

    class BlankSlate < BasicObject
      def self.__forbidden_names
        Config.instance_methods + PERMANENT_METHODS
      end

      private

      def self.inherited(subclass)
        _eraseable_methods.each{ |method_name| undef_method method_name }
      end

      def self._eraseable_methods
        instance_methods - PERMANENT_METHODS
      end

      def _taken?(name)
        Config.instance_methods.include? name
      end

      PERMANENT_METHODS = [:instance_eval, :__send__, :object_id, :_taken?, :asset_folder]
    end
  end
end
