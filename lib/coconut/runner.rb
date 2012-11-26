require_relative 'config'
require_relative 'dsl/environment'

module Coconut
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

  class Runner
    def initialize(current_environment)
      @current_environment = current_environment
      @config = {}
    end

    def run(&config)
      instance_eval &config
      Config.new(@config)
    end

    private

    def method_missing(name, *args, &block)
      @config[name] = AssetRunner.new(@current_environment).run(&block)
    end
  end

  class AssetRunner
    def initialize(current_environment)
      @current_environment = current_environment
    end

    def run(&config)
      instance_eval &config
      @config
    end

    private

    def environment(environment, &environment_config)
      @config = Dsl::Environment.run(&environment_config) if current? environment
    end

    def current?(environment)
      @current_environment.to_sym == environment.to_sym
    end
  end
end
