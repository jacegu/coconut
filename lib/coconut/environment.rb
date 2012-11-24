require 'delegate'
require 'hashie'
require_relative 'runner'

module Coconut
  class Environment < DelegateClass(Hashie::Mash)
    def initialize(&config)
      super Hashie::Mash.new
      run config
    end

    private

    def run(config)
      Runner.new run: config, method_missing: method(:configure_property)
    end

    def configure_property(name, values)
      self[name] = values.first
    end
  end
end
