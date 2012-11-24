require 'delegate'
require 'hashie'
require_relative 'environment'

module Coconut
  class Asset < DelegateClass(Hashie::Mash)
    def initialize(current_environment, &config)
      super Hashie::Mash.new
      run config, current_environment if block_given?
    end

    def environment(environment_name, &config)
      merge! Environment.new(&config) if current? environment_name
    end

    private

    def run(config, environment)
      @current_environment = environment
      instance_eval &config
    end

    def current?(environment)
      environment.to_sym == @current_environment.to_sym
    end
  end
end
